require 'formula'

class LemonGraph < Formula
  homepage 'http://lemon.cs.elte.hu/trac/lemon'
  url 'http://lemon.cs.elte.hu/pub/sources/lemon-1.3.tar.gz'
  sha1 'c833604b790e6f45d5cf8da304d9b23ba74eae6c'

  depends_on 'cmake' => :build
  depends_on 'glpk' => :recommended

  fails_with :clang do
    # http://lemon.cs.elte.hu/trac/lemon/ticket/471
    build 500
    cause <<-EOS.undent
      dependent using declaration resolved to type without 'typename'
      EOS
  end

  def install
    args = std_cmake_args
    if build.with? 'glpk'
      args << '-DLEMON_ENABLE_GLPK=YES'
      args << "-DLEMON_GLPK_ROOT_DIR=#{Formula.factory('glpk').prefix}"
    end

    mkdir 'lemon-build' do
      system 'cmake', '..', *args
      system 'make'
      system 'make', 'check'
      system 'make', 'install'
    end
  end
end
