

S08_reproductibilite.pdf: S08_reproductibilite.md makefile
	pandoc $< -o $@ -t beamer --smart -V theme=Copenhagen -V colortheme=beaver --toc