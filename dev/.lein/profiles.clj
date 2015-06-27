{:user
 {:dependencies [[alembic "0.3.2"]]
  :plugins [[cider/cider-nrepl "0.9.0"]
            [com.palletops/lein-shorthand "0.4.0"]
            [lein-ancient "0.6.7"]]
  :shorthand {. [alembic.still/distill
                 alembic.still/load-project
                 alembic.still/lein]}}}
