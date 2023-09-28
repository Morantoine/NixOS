{ writeShellApplication
, rizin
, discord
}:

writeShellApplication rec {
  name = "krisp-patch";

  runtimeInputs = [ rizin ];

  text = ''
    discord_version="${discord.version}"
    file="$HOME/.config/discord/$discord_version/modules/discord_krisp/discord_krisp.node"
    addr=$(rz-find -x '4881ec00010000' "$file" | head -n1)
    rizin -q -w -c "s $addr + 0x30 ; wao nop" "$file"
  '';
}
