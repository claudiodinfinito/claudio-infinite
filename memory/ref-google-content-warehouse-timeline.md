# Google Content Warehouse Leak - Timeline Forensics

ID: REF-GOOGLE-LEAK-003
Status: active
Tags: #google #leak #forensics #timeline
Keys: google, leak, timeline, versions, hex, discovery-service
Last reviewed: 2026-02-18

---

## Timeline del Leak

### Cronología de Versiones Elixir

| Versión | Fecha Release | Estado |
|---------|---------------|--------|
| v0.2.0 | 15 Mar 2024 | 🴢 PRIMERA - Todos los modelos internos |
| v0.3.0 | 17 Mar 2024 | 🴢 Aún tiene modelos sensibles |
| v0.4.0 | 28 Mar 2024 | 🴢 Mismo día que GitHub leak |
| v0.5.0 | 7 May 2024 | 🔴 ÚLTIMA versión "sucia" - Mismo día que removieron de GitHub |
| v0.6.0 | 25 Jul 2024 | ✅ Primera versión "limpia" - Después del escándalo |
| v0.6.1 | 6 Dec 2024 | ✅ Latest - Limpio |

### Cronología del Leak Público

| Fecha | Evento |
|-------|--------|
| 15 Mar 2024 | Primera versión Elixir publicada (v0.2.0) |
| 27 Mar 2024 | Código subido a GitHub (según SparkToro) |
| 7 May 2024 | Google remueve del discovery service / GitHub |
| 27 May 2024 | **Artículo SparkToro publicado** - Escándalo público |
| 25 Jul 2024 | Google publica v0.6.0 "limpia" |

---

## Inferencias Clave

### 1. El leak fue AUTOMÁTICO

**Evidencia:**
- El paquete Elixir se genera automáticamente desde el discovery service de Google
- No hubo intervención manual de Google para crear estos paquetes
- El generador encontró el API expuesto y creó el cliente

**Conclusión:**
Google accidentalmente publicó el Content Warehouse API en su discovery service. El sistema automático de generación de clientes Elixir lo encontró y documentó todo.

### 2. Google no sabía hasta Mayo 2024

**Evidencia:**
- v0.2.0 a v0.5.0 todas tienen modelos internos
- La limpieza solo ocurre en v0.6.0 (Julio)
- El 7 de Mayo removieron el código de GitHub

**Conclusión:**
Google descubrió el leak alrededor del 7 de Mayo 2024, posiblemente alertados por el source anónimo o por la preparación del artículo de SparkToro.

### 3. Hex.pm es EVIDENCIA INDELEBLE

**Por qué importa:**
- Los paquetes de Hex.pm son **inmutables**
- No se pueden eliminar después de publicados
- Google NO puede hacer nada para remover estas versiones
- Cualquiera puede descargarlas y analizarlas

**Conclusión:**
El paquete Elixir es una "fotografía" del leak que Google no puede borrar. Es evidencia forense permanente.

### 4. v0.5.0 es la versión "ideal" para análisis

**Por qué:**
- Es la última versión antes del escándalo público
- Aún tiene modelos internos
- Fue publicada el MISMO DÍA que Google removió el código
- Posiblemente captura el estado "final" del leak antes de la limpieza

### 5. El discovery service filtró APIs que no deberían ser públicas

**Evidencia:**
- Content Warehouse NO es una API pública documentada
- Contiene sistemas internos (AbuseIAm, Anchors con campos internos)
- Se generó automáticamente un cliente completo

**Conclusión:**
Google tiene un problema de seguridad en su pipeline de discovery service. APIs internas se pueden filtrar si no están correctamente marcadas como privadas.

---

## Modelos Eliminados Entre Versiones

### v0.2.0 → v0.4.0

| Modelo | v0.2.0 | v0.4.0 | Significado |
|--------|--------|--------|-------------|
| AbuseiamVideoReviewData | ✓ | ✗ | Datos de revisión de videos |
| AbuseiamVideoReviewer | ✓ | ✗ | Info de reviewers |
| AbuseiamManualReviewTool | ✓ | ✗ | Herramientas de revisión manual |
| AbuseiamClusterEvaluationContext | ✓ | ✗ | Contexto de evaluación en cluster |
| AbuseiamFeature | ✓ | ✗ | Features de clasificación |
| Anchors con campos extendidos | ✓ | Reducido | Campos internos de ranking |

### v0.5.0 → v0.6.0

| Cambio | Descripción |
|--------|-------------|
| AppsPeopleOzExternalMergedpeopleapi* | Reducido significativamente |
| Campos internos de Anchors | Removidos |
| Links go/ internos | Limpiados |

---

## Qué significa esto para SEO

### 1. Las versiones antiguas tienen información que Google quitó

- v0.2.0 tiene modelos completos de video review
- Muestra exactamente cómo Google clasifica contenido
- Documenta el flujo de revisión manual

### 2. Los campos de Anchors revelan señales de calidad

```
v0.2.0 tiene campos que desaparecieron:
- isLocal (¿mismo dominio?)
- forwardingTypes (cómo se redirige)
- firstseenNearCreation (freshness)
- compressedOriginalTargetUrl
- encodedNewsAnchorData
```

### 3. AbuseIAm muestra el sistema de moderación completo

```
v0.2.0/v0.3.0 tienen:
- VideoReviewData: cómo se revisan videos
- ManualReviewTool: herramientas internas
- Feature: qué features usa para clasificar
```

---

## Lecciones de Seguridad

1. **Discovery services pueden filtrar APIs internas** - Si no están marcadas como privadas
2. **Los mirrors públicos son indelebles** - Hex.pm, npm, PyPI no permiten eliminar
3. **La automatización puede exponer secrets** - El generador documentó todo
4. **Timestamps cuentan la historia** - Las fechas de release revelan cuándo Google supo

---

## URLs para Análisis Forense

- v0.2.0: https://hexdocs.pm/google_api_content_warehouse/0.2.0/api-reference.html
- v0.5.0: https://hexdocs.pm/google_api_content_warehouse/0.5.0/api-reference.html
- v0.6.0: https://hexdocs.pm/google_api_content_warehouse/0.6.0/api-reference.html

**Recomendación:** Descargar v0.2.0 completa antes de que "desaparezca".

---

## Hipótesis e Inferencias Críticas

### Hipótesis 1: Google NO supo hasta Mayo

**Evidencia:**
- v0.2.0 → v0.3.0: Solo 2 días (update rutinario)
- v0.3.0 → v0.4.0: 11 días (normal)
- v0.4.0 → v0.5.0: 40 días (sin cambios drásticos)

Si Google ya sabía en Marzo, hubieran removido el discovery service inmediatamente.

**Pero contradice con:**
- v0.4.0 ya tiene menos campos que v0.2.0

**Inferencia:** Limpieza gradual silenciosa.

---

### Hipótesis 2: v0.5.0 es EVIDENCIA DE PÁNICO

El generador automático corrió ANTES de que Google pudiera detenerlo. Esto prueba que el leak fue automático.

---

### Hipótesis 3: La limpieza fue SELECTIVA

Google quitó:
- Procesos de moderación manual
- Herramientas internas
- Señales de ranking detalladas

Google dejó:
- APIs necesarias para funcionamiento
- Estructuras básicas

---

### Hipótesis 4: Limpieza gradual vs descubrimiento súbito

**Timeline revisada:**
1. **Mar:** Leak inicial, Google no sabe
2. **Mar-May:** Posible limpieza silenciosa entre versiones
3. **7 May:** PÁNICO → Remoción total
4. **May-Jul:** Auditoría + rediseño
5. **25 Jul:** Versión limpia

---

### Hipótesis 5: El discovery service sigue siendo vulnerable

326 APIs en el repo. ¿Cuántos otros tienen info sensible?

---

### Qué versión priorizar

- **v0.2.0**: TODO antes de cualquier limpieza
- **v0.5.0**: Lo que quedó después de limpieza silenciosa

Comparar ambas revela qué quitó Google gradualmente.

---

_Creado: 18 Feb 2026 - Análisis forense de versiones_
