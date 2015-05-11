##! /usr/bin/env sh

echo SYSTEM
uname -a
echo "PATH"
tr ':' '\n' <<< "$PATH"
echo "LD_LIBRARY_PATH"
tr ':' '\n' <<< "$LD_LIBRARY_PATH"
echo "DYLD_LIBRARY_PATH = $DYLD_LIBRARY_PATH"
echo "FC = $FC"
echo "CC = $CC"
echo "CPP = $CPP"
echo "CXX = $CXX"
echo "FCFLAGS = $FCFLAGS"
echo "FFLAGS = $FFLAGS"
echo "CFLAGS = $CFLAGS"
echo "CPPFLAGS = $CPPFLAGS"
echo "CXXFLAGS = $CXXFLAGS"
echo "LDFLAGS = $LDFLAGS"
echo "DYLDFLAGS = $DYLDFLAGS"

if (which gfortran &> /dev/null); then
    echo
    echo GFORTRAN
    which gfortran
    gfortran --version
fi

if (which gcc &> /dev/null); then
    echo
    echo GCC
    which gcc
    gcc --version
fi

if (which g++ &> /dev/null); then
    echo
    echo G++
    which g++
    g++ --version
fi

if (which clang &> /dev/null); then
    echo
    echo CLANG
    which clang
    clang --version
fi

if (which clang++ &> /dev/null); then
    echo
    echo CLANG++
    which clang++
    clang++ --version
fi

echo
echo PYTHON
if (which python &> /dev/null); then
    which python
    echo "PYTHONPATH = $PYTHONPATH"
    python -c "import sys; print sys.version"
else
    echo "No python found"
fi
echo "EXPLICIT PYTHON2 and PYTHON3 INSTALLATIONS:"
which python2 || echo "No python2"
which python3 || echo "No python3"
