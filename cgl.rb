require 'formula'

class Cgl < Formula
  homepage 'https://projects.coin-or.org/Cgl'
  url 'http://www.coin-or.org/download/source/Cgl/Cgl-0.58.3.tgz'
  sha1 '81a823a91c4b2254c22dbea685f6673a7cb3ceb5'
  head 'https://projects.coin-or.org/svn/Cgl/stable/0.58'

  devel do
    head 'https://projects.coin-or.org/svn/Cgl/trunk'
  end

  depends_on :fortran

  conflicts_with '/homebrew/science/coinmp', :because => 'CoinMP already provides CGL (and more).'
  conflicts_with '/homebrew/science/coinutils', :because => 'CGL already provides CoinUtils (and more).'
  conflicts_with 'clp', :because => 'CGL already provides CLP (and more).'
  conflicts_with 'cbc', :because => 'CBC already provides CGL (and more).'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ohai 'Test results are in ~/Library/Logs/Homebrew/cgl. Please check.'
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
