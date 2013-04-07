all: nasal_words.txt
	swipl -O -o 2013-03-24-puzzler -c puzzler.pl
	@echo
	@echo "Now run ./2013-03-24-puzzler and invoke the 'solve' goal"

nasal_words.txt:
	egrep "^[a-z]{2}[nal][a-z]{2}$$" ../resources/12dicts-5.0/3esl.txt > nasal_words.txt

clean:
	rm -f nasal_words.txt
	rm -f 2013-03-24-puzzler

