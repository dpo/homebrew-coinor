require 'formula'

class Clp < Formula
  homepage 'https://projects.coin-or.org/Clp'
  url 'http://www.coin-or.org/download/source/Clp/Clp-1.15.4.tgz'
  sha1 'a13f80b331cfc665311d785dfb3b6162dadd0626'
  head 'https://projects.coin-or.org/svn/Clp/trunk'

  depends_on :fortran

  conflicts_with '/homebrew/science/coinmp', :because => 'CoinMP already provides CLP (and more).'
  conflicts_with '/homebrew/science/coinutils', :because => 'CLP already provides CoinUtils (and more).'
  conflicts_with 'cbc', :because => 'CBC already provides CLP (and more).'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
