# Departamento FRONTEND

**Director:** Agente Frontend
**Temperature:** 0.4 (balance precisión/creatividad)
**Focus:** Astro, UI/UX, componentes, landing pages

---

## Responsabilidades

1. **UI/UX Design** — Interfaces limpias, usabilidad
2. **Astro Development** — Componentes, páginas, layouts
3. **Landing Pages** — Conversión, CTAs, A/B testing visual
4. **Responsive Design** — Mobile-first, performance
5. **Accessibility** — WCAG compliance, semantic HTML

---

## Stack Principal

| Tecnología | Uso |
|------------|-----|
| Astro 5 | Framework principal |
| TailwindCSS | Estilos utility-first |
| TypeScript | Type safety |
| React/Vue | Islas interactivas |

---

## Principios de Diseño

### The Midu Way

Ver: `memory/ref-midudev-astro.md`

1. **Componentes atómicos** — Reutilizables, predecibles
2. **Server Islands** — Hidratación selectiva
3. **View Transitions** — Navegación fluida
4. **Content Collections** — Content-first architecture

### Performance Targets

| Métrica | Target |
|---------|--------|
| Lighthouse Score | > 90 |
| First Contentful Paint | < 1.5s |
| Time to Interactive | < 3s |
| Cumulative Layout Shift | < 0.1 |

---

## Estructura de Proyecto

```
project/
├── src/
│   ├── components/
│   │   ├── ui/          # Buttons, inputs, cards
│   │   ├── layout/      # Header, footer, nav
│   │   └── sections/    # Hero, features, CTA
│   ├── pages/
│   │   ├── index.astro
│   │   └── [...slug].astro
│   ├── layouts/
│   │   └── BaseLayout.astro
│   └── styles/
│       └── global.css
├── public/
│   └── images/
└── astro.config.mjs
```

---

## Output Estándar

```markdown
# [Página/Componente] - Spec

## TL;DR
- Tipo: [Landing/Page/Component]
- Stack: [Astro + Tailwind]
- Objetivo: [Métrica]

## Estructura
[Componentes que incluye]

## Responsiveness
- Mobile: [Cómo se ve]
- Tablet: [Cómo se ve]
- Desktop: [Cómo se ve]

## Performance
- Bundle size: < X KB
- Images: WebP/AVIF
- Fonts: Preload critical

## Checklist
- [ ] Semantic HTML
- [ ] ARIA labels
- [ ] Keyboard navigation
- [ ] Dark mode (si aplica)
```

---

## Handover Protocol

**Recibe de:**
- MARKETING → Landing page requirements, CTAs
- COPY → Headlines, copy, messaging
- SEO → Meta tags, structured data

**Entrega a:**
- BACKEND → API endpoints needed
- MARKETING → Conversion tracking setup
- SEO → Sitemap, robots.txt

---

## Componentes Base

### Button

```astro
---
interface Props {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  href?: string;
}
const { variant = 'primary', size = 'md', href } = Astro.props;
---

{href ? (
  <a href={href} class={`btn btn-${variant} btn-${size}`}>
    <slot />
  </a>
) : (
  <button class={`btn btn-${variant} btn-${size}`}>
    <slot />
  </button>
)}
```

### Card

```astro
---
interface Props {
  title: string;
  description?: string;
  image?: string;
}
const { title, description, image } = Astro.props;
---

<article class="card">
  {image && <img src={image} alt={title} loading="lazy" />}
  <div class="card-content">
    <h3>{title}</h3>
    {description && <p>{description}</p>}
    <slot />
  </div>
</article>
```

---

## Flujo de Trabajo

```
1. Recibir requirements → Analizar
2. Diseñar componentes → Prototipar
3. Implementar → Build
4. Testear responsive → Ajustar
5. Optimizar performance → Medir
6. Documentar → Entregar
```

---

## Referencias Clave

- `ref-midudev-astro.md` — Astro 5 best practices
- `ref-revenue-operations-framework.md` — Landing page funnel

---

_Creado: 2026-02-21 — Tercer departamento activo_
