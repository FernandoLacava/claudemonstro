#!/bin/bash
# Cole este conteúdo no "Setup script" do ambiente na nuvem (claude.ai/code).
claude plugin marketplace add FernandoLacava/claudemonstro || true
claude plugin install monstro@claudemonstro --scope user || true
node -e 'const f=require("os").homedir()+"/.claude/settings.json",fs=require("fs");let s={};try{s=JSON.parse(fs.readFileSync(f))}catch{}s.statusLine={type:"command",command:"node ~/.claude/claudemonstro-statusline.js",padding:0};fs.writeFileSync(f,JSON.stringify(s,null,2))' || true
