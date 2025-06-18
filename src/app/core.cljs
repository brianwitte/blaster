(ns app.core
  (:require [reagent.core :as r]
            [reagent.dom :as rdom]))

;; State
(defonce counter (r/atom 0))

;; Components
(defn counter-component []
  [:div
   [:h1 "🎉 Shadow CLJS + Reagent"]
   [:p "Welcome to your ClojureScript app!"]
   [:div.counter @counter]
   [:div
    [:button {:on-click #(swap! counter dec)} "−"]
    [:button {:on-click #(reset! counter 0)} "Reset"]
    [:button {:on-click #(swap! counter inc)} "+"]
    ]
   [:p "Click the buttons to change the counter!"]])

;; Initialize the app
(defn init! []
  (println "Initializing app...")
  (rdom/render [counter-component]
               (.getElementById js/document "app")))

;; Hot reload support
(defn ^:dev/after-load reload! []
  (println "Reloading...")
  (init!))
