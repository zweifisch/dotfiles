{:user
 {:dependencies [
                 ;; A library for use In the REPL. Add dependencies to your classpath, reload your project.clj file, and invoke leiningen tasks.
                 [alembic "0.3.2"]
                 [org.clojure/tools.nrepl "0.2.13"]]
  :plugins [[cider/cider-nrepl "0.24.0"]
            ;;nREPL middleware to support editor-agnostic refactoring
            [refactor-nrepl "2.5.0"]
            ;; A leiningen plugin to create clojure namespaces with short names, so you can easily call utility functions in the REPL using fully qualified symbols.
            ;; [com.palletops/lein-shorthand "0.4.0"]
            ;; Check your Projects for outdated Dependencies.
            [lein-ancient "0.6.15"]
            ;; A leiningen plugin for generating standalone console executables for your project.
            [lein-bin "0.3.5"]]
  :shorthand {. [alembic.still/distill
                 alembic.still/load-project
                 alembic.still/lein]}}}
