import gleam/int
import gleam/io
import gleam/list
import gleam/string
import range
import simplifile

pub fn main() -> Nil {
  let #(id_ranges, seen_ids) = parse_input("input.txt")
  part1(id_ranges, seen_ids) |> int.to_string |> io.println
  part2(id_ranges) |> int.to_string |> io.println
}

fn part1(id_ranges: List(range.Range), ids: List(Int)) -> Int {
  ids
  |> list.filter(fn(id) {
    list.any(id_ranges, fn(range) { range.includes(id, in: range) })
  })
  |> list.length
}

fn part2(id_ranges: List(range.Range)) -> Int {
  id_ranges
  |> range.sort()
  |> range.merge_sorted()
  |> list.fold(0, fn(acc, r) { acc + range.size(r) })
}

fn parse_input(filename: String) -> #(List(range.Range), List(Int)) {
  let assert Ok(contents) = simplifile.read(from: filename)
  let assert [ranges, ids] = string.split(contents, on: "\n\n")
  let id_ranges =
    ranges
    |> string.trim
    |> string.split(on: "\n")
    |> list.map(range.parse)

  let ids =
    ids
    |> string.trim()
    |> string.split("\n")
    |> list.map(fn(str) {
      let assert Ok(x) = int.parse(str)
      x
    })
  #(id_ranges, ids)
}
