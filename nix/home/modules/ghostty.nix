{ config, ... }: {
    home.file."Library/Application Support/com.mitchellh.ghostty/config" = {
        source = config.lib.file.mkOutOfStoreSymlink (toString ../../../ghostty/config);
    };
}
