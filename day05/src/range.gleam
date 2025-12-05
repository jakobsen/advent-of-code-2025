import gleam/int
import gleam/list
import gleam/order
import gleam/string

pub type Range {
  Range(from: Int, to: Int)
}

pub fn parse(str: String) -> Range {
  let assert [from, to] = string.split(str, "-")
  let assert Ok(from) = int.parse(from)
  let assert Ok(to) = int.parse(to)
  Range(from:, to:)
}

pub fn includes(value: Int, in range: Range) -> Bool {
  range.from <= value && value <= range.to
}

pub fn size(range: Range) -> Int {
  range.to - range.from + 1
}

pub fn sort(ranges: List(Range)) -> List(Range) {
  list.sort(ranges, fn(a, b) { int.compare(a.from, b.from) })
}

pub fn merge_sorted(ranges: List(Range)) -> List(Range) {
  case ranges {
    [] -> []
    [a] -> [a]
    [a, b, ..rest] -> {
      case int.compare(a.to, b.from) {
        order.Lt -> [a, ..merge_sorted([b, ..rest])]
        _ -> {
          let merged_range = Range(a.from, int.max(a.to, b.to))
          merge_sorted([merged_range, ..rest])
        }
      }
    }
  }
}
