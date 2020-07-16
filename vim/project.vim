
if filereadable('CMakeLists.txt')
	let g:project_type='cmake'
elseif filereadable('Makefile')
	let g:project_type='make'
elseif filereadable('pom.xml')
	let g:project_type='maven'
elseif filereadable('package.json')
	let g:project_type='node'
elseif filereadable('composer.json')
	let g:project_type='php'
else
	let g:project_type=''
endif

if len(g:project_type)
	exec 'source ~/.vim/project/' . g:project_type . '.vim'
endif

