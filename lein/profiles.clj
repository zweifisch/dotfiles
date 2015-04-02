{:user
 {:dependencies [[alembic "0.3.2"]]
  :plugins [[cider/cider-nrepl "0.9.0-SNAPSHOT"]
            [com.palletops/lein-shorthand "0.4.0"]]
  :shorthand {. [alembic.still/distill
                 alembic.still/load-project
                 alembic.still/lein]}}}
