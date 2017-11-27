{:user
 {:dependencies [[alembic "0.3.2"]
                 [org.clojure/tools.nrepl "0.2.12"]]
  :plugins [[cider/cider-nrepl "0.15.1"]
            [refactor-nrepl "1.1.0"]
            [com.palletops/lein-shorthand "0.4.0"]
            [lein-ancient "0.6.7"]
            [lein-bin "0.3.5"]
            [lein-license "0.1.4"]]
  :shorthand {. [alembic.still/distill
                 alembic.still/load-project
                 alembic.still/lein]}}}
