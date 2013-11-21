require 'formula'

class Cbc < Formula
  homepage 'https://projects.coin-or.org/Cbc'
  url 'http://www.coin-or.org/download/source/Cbc/Cbc-2.8.6.tgz'
  sha1 '71b1a4223c6c157376a706bbc84580be4ea2adf1'
  head 'https://projects.coin-or.org/svn/Cbc/trunk'

  depends_on :fortran

  conflicts_with '/homebrew/science/coinmp', :because => 'CoinMP already provides Cbc (and more).'
  conflicts_with '/homebrew/science/coinutils', :because => 'Cbc provides CoinUtils (and more).'
  conflicts_with 'cgl', :because => 'Cbc provides CGL (and more).'
  conflicts_with 'clp', :because => 'Cbc provides CLP (and more).'

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make"
    system "make test"
    ohai "Test results are in ~/Library/Logs/Homebrew/cbc. Please check."
    ENV.deparallelize  # make install fails in parallel.
    system "make install"
  end
end
