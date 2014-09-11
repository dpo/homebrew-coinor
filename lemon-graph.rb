require 'formula'

class LemonGraph < Formula
  homepage 'http://lemon.cs.elte.hu/trac/lemon'
  url 'http://lemon.cs.elte.hu/pub/sources/lemon-1.3.1.tar.gz'
  sha1 'b23d64c21b4b9088ad51e85316964a4a4138f82a'

  depends_on 'cmake' => :build
  depends_on 'glpk' => :recommended

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
