{
  config,
  lib,
  dotfilesDir,
  ...
}:
{
  home.file.".claude" = {
    source = config.lib.file.mkOutOfStoreSymlink "${dotfilesDir}/.claude";
    force = true;
  };
}
