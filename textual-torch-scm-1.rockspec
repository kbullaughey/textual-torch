package = "textual-torch"
version = "scm-1"

source = {
   url = "git://github.com/kbullaughey/textual-torch",
   tag = "master"
}

description = {
   summary = "Utility function for dealing with text in NLP applications using torch",
   detailed = [[
   	    Assorted utility functions for manipulating text. Aimed at neural-net based NLP applications using Torch.
   ]],
   homepage = "https://github.com/kbullaughey/textual-torch"
}

dependencies = {
   "torch >= 7.0"
}

build = {
   type = "command",
   build_command = [[
cmake -E make_directory build;
cd build;
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/.." -DCMAKE_INSTALL_PREFIX="$(PREFIX)"; 
$(MAKE)
   ]],
   install_command = "cd build && $(MAKE) install"
}
