# Como obter a CURSOR_API_KEY (quando Integracoes da erro)

## Problema: "Algo deu errado" ao clicar em Integracoes

Isso e um **bug do site do Cursor**, nao do seu projeto. Outros usuarios reportam o mesmo.

### Tente nesta ordem

**1. URL em ingles (mais comum funcionar)**
- https://cursor.com/en-US/dashboard/integrations
- https://cursor.com/en-US/dashboard/api

**2. Janela anonima**
- Chrome: `Ctrl+Shift+N`
- Acesse a URL em ingles acima e faca login

**3. Desativar VPN/proxy**
- Se usa VPN ou proxy (ex. 127.0.0.1:7890), desligue e tente de novo

**4. Limpar cookies do cursor.com**
- Chrome → Configuracoes → Privacidade → Cookies → `cursor.com` → Remover

**5. Pelo app Cursor (sem site)**
- No Cursor: `Ctrl+Shift+P` → digite **Cursor Settings**
- Procure **Integrations** ou **API Keys** nas configuracoes da conta

## Formato da chave

Comeca com `key_` ou `crsr_` — **nao** e o codigo do GitHub (D3F7-0551).

## Se nada funcionar

O projeto ja esta no GitHub com README. Para testar a **API** depois, quando o dashboard voltar:
1. Gere a chave em Integrations
2. Cole no `.env`
3. Use o atalho **Cursor Cloud Agent**

Enquanto isso, use **Cloud Agents pelo proprio Cursor**:
- `Ctrl+Shift+P` → **Cloud Agent** ou aba **Agents** no chat
- Nao precisa de API key para isso

## Reportar o bug

https://forum.cursor.com/c/bug-reports
