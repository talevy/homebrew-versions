class Tomcat6 < Formula
  desc "Implementation of Java Servlet and JavaServer Pages"
  homepage "https://tomcat.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=tomcat/tomcat-6/v6.0.45/bin/apache-tomcat-6.0.45.tar.gz"
  sha256 "8f9bd3e02f1e7798ca8f99f3254594688307ced3e7325dfb10f336750d82482d"

  bottle :unneeded

  keg_only "Some scripts that are installed conflict with other software."

  option "with-fulldocs", "Install full documentation locally"

  resource "fulldocs" do
    url "https://www.apache.org/dyn/closer.cgi?path=/tomcat/tomcat-6/v6.0.45/bin/apache-tomcat-6.0.45-fulldocs.tar.gz"
    version "6.0.45"
    sha256 "aa1cbef0b73047425174731e1bea5567eacd6cbb7f9d7cd2c2495ba38fca2109"
  end

  def install
    rm_rf Dir["bin/*.{cmd,bat]}"]
    libexec.install Dir["*"]
    (libexec+"logs").mkpath
    bin.mkpath
    Dir["#{libexec}/bin/*.sh"].each { |f| ln_s f, bin }
    (share/"fulldocs").install resource("fulldocs") if build.with? "fulldocs"
  end

  def caveats; <<-EOS.undent
    Some of the support scripts used by Tomcat have very generic names.
    These are likely to conflict with support scripts used by other Java-based
    server software.

    You can link Tomcat into PATH with:

      brew link tomcat6

    or add #{bin} to your PATH instead.
    EOS
  end
end
