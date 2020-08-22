# Package

version       = "0.1.0"
author        = "Steve Marx"
description   = "HashCache: we cache hashes!"
license       = "MIT"
srcDir        = "src"
bin           = @["hashcache"]



# Dependencies

requires "nim >= 1.2.6"
requires "redis >= 0.2.0"
