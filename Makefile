
install:
	for i in $$(ls); do ln -s $$(pwd)/$$i ~/.$$i; done

