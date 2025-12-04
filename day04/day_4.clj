(ns day-4
  (:require [clojure.string :as str]))

(defn build-board [raw-data]
  (-> raw-data
      (str/trim)
      (str/split-lines)))

(defn get-all-coords [board]
  (for [i (range (count board)) j (range (count (first board)))] [i j]))

(defn get-tile [board [i j]]
  (-> board
      (get i)
      (get j)))

(defn get-neighbour-coords [[i j]]
  (for [di [-1 0 1] dj [-1 0 1]
        :when (not (and (= di 0) (= dj 0)))]
    [(+ i di) (+ j dj)]))

(defn is-paper? [board coords]
  (= (get-tile board coords) \@))

(defn reachable? [board coords]
  (and
   (is-paper? board coords)
   (<
    (count
     (filter
      (fn [coords] (is-paper? board coords))
      (get-neighbour-coords coords)))
    4)))

(comment
  (def test-board (build-board (slurp "test.txt")))
  (def real-board (build-board (slurp "input.txt")))

  (count (filter (fn [coords] (reachable? real-board coords)) (get-all-coords real-board))))
