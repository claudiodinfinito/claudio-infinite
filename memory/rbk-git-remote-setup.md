# Runbook: Git Remote Setup

**Propósito:** Configurar el repositorio remoto del workspace para persistencia externa.
**Frecuencia:** Una sola vez o cuando cambie el servidor de git.

---

## 1. Obtener URL del Repositorio

Solicitar a Daniel la URL del repositorio (GitHub, GitLab, Gitea, etc.).
Formato esperado: `https://github.com/usuario/repo.git` o `git@github.com:usuario/repo.git`.

---

## 2. Configuración Inicial

```bash
# Entrar al workspace
cd /root/.openclaw/workspace

# Verificar si ya existe un remote
git remote -v

# Si no existe, añadirlo (usualmente 'origin')
git remote add origin <URL_PROPORCIONADA>

# Verificar de nuevo
git remote -v
```

---

## 3. Primer Push

```bash
# Subir la rama master y establecer tracking
git push -u origin master
```

**Nota:** Si el repo remoto no está vacío, puede ser necesario hacer un pull primero:
`git pull origin master --rebase`

---

## 4. Solución de Problemas

### Error: Remote origin already exists
```bash
git remote set-url origin <NUEVA_URL>
```

### Error: Permission denied (publickey)
- Daniel debe añadir la SSH key del VPS al proveedor de git.
- O usar HTTPS con un Personal Access Token (PAT).

---

## 5. Workflow Diario Post-Configuración

A partir de este punto, el flujo de micro-tareas incluye push:
1. Tarea
2. `git add .`
3. `git commit -m "..."`
4. `git push`

---

_Creado: 2026-02-20 16:40 UTC - Micro-tarea de 3 min_
