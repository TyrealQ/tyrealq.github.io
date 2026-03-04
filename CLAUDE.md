# CLAUDE.md — tyrealq.github.io

## Owner & Site Identity

- **Q** = Dr. Yizhou (Tyreal) Qian 钱亦舟, Associate Professor at Louisiana State University
- **Site title**: "Dr. Q"
- **Author display**: "Yizhou (Tyreal) Qian" with Chinese name 钱亦舟
- **Email**: yqian@lsu.edu
- **Research focus**: sport management, esports, NLP/AI, computer vision, datasets, agent skills
- **Academic profiles**: [Google Scholar](https://scholar.google.com/citations?user=1FtSN0gAAAAJ&hl=en), [ORCID](http://orcid.org/0000-0002-5362-2634), [GitHub](https://github.com/TyrealQ), [YouTube](https://youtube.com/@tyrealq), [LinkedIn](https://www.linkedin.com/in/tyreal-yizhou-qian)
- **Avatar**: `images/Ty.png`

## Build & Serve

```bash
# Local development (requires Ruby + Bundler)
bundle install
bundle exec jekyll serve -l -H localhost

# Docker alternative
docker build -t academic-pages .
docker run -p 4000:4000 -v $(pwd):/usr/src/app academic-pages

# Rebuild JS assets (requires Node.js)
npm install
npm run build:js        # one-time bundle
npm run watch:js        # watch mode
```

Site serves at `http://localhost:4000`. Changes to `_config.yml` require a server restart.

## Architecture

**Theme**: Academic Pages (fork of Minimal Mistakes) | **Markdown**: Kramdown with GFM | **Plugins**: jekyll-feed, jekyll-sitemap, jekyll-paginate, jemoji

### Collections (defined in `_config.yml`)

| Collection | Directory | Permalink | Description |
|---|---|---|---|
| publications | `_publications/` | `/publications/:path/` | Journal articles, conference papers |
| talks | `_talks/` | `/talks/:path/` | Podcasts and teaching demos |
| portfolio | `_portfolio/` | `/portfolio/:path/` | AI-generated art / fun stuff |
| teaching | `_teaching/` | `/teaching/:path/` | Course materials (placeholder) |
| posts | `_posts/` | `/:categories/:title/` | Blog posts (placeholder) |

### Key Directories

- `_pages/` — Static pages (about, cv, archive pages); explicitly included via `_config.yml`
- `_includes/` — Reusable HTML partials (author profile, header, footer)
- `_layouts/` — Page templates (`single`, `talk`, etc.)
- `_sass/` — SCSS stylesheets (compressed output)
- `_data/navigation.yml` — Header navigation links and order
- `_drafts/` — Unpublished content
- `images/` — Site images
- `files/` — Downloadable files (PDFs, etc.)
- `assets/js/` — JavaScript; `main.min.js` is the bundled output

### Content Generation Pipeline

`markdown_generator/` contains Python scripts and Jupyter notebooks that convert TSV data into Markdown collection files:

- `publications.tsv` → `publications.py` / `publications.ipynb` → `_publications/*.md`
- `talks.tsv` → `talks.py` / `talks.ipynb` → `_talks/*.md`
- `PubsFromBib.ipynb` / `OrcidToBib.ipynb` — Import from BibTeX/ORCID

## Site Navigation

Header links (defined in `_data/navigation.yml`):

| Label | URL | Maps to |
|---|---|---|
| Curriculum Vitae | `/cv/` | `_pages/cv.md` |
| Research Highlights | `/publications/` | `_pages/publications.html` |
| Teaching Demos | `/talks/` | `_pages/talks.html` |
| Fun Stuff | `/portfolio/` | `_pages/portfolio.html` |

Homepage: `_pages/about.md` (permalink: `/`)

## Content Inventory

### Publications (`_publications/`) — 10 files, ALL ACTIVE

| File | Title (short) | Venue | Category | Date |
|---|---|---|---|---|
| `B50.md` | Trump's Break 50 YouTube appearance | NASSM 2025, San Diego | conferences | 2025-05 |
| `CS_Olympics.md` | 2022 Beijing Winter Olympics tweets on X | Communication & Sport | manuscripts | 2024-07 |
| `ESMQ_esports.md` | Esports spectator motivation scale (MSES) | European Sport Management Quarterly | manuscripts | 2020-06 |
| `HICSS58.md` | Esports at 2023 Asian Games (BERTopic + GPT-4) | HICSS-58, Big Island, HI | conferences | 2025-01 |
| `JBR_gamification.md` | Gamification in esports livestreaming | Journal of Business Research | manuscripts | 2022-06 |
| `JRCS_Trump.md` | Human-AI analysis of Trump Break 50 | Journal of Retailing and Consumer Services | manuscripts | 2026-01 |
| `JSM_TS.md` | Taylor Swift & NFL Instagram analysis | Journal of Sport Management | manuscripts | 2026-01 |
| `SMR_costream.md` | Twitch TNF co-streaming | Sport Management Review | manuscripts | 2021-07 |
| `SMR_experience.md` | LLM for stadium review sentiment (GPT-3.5 + RoBERTa) | Sport Management Review | manuscripts | 2024-08 |
| `Smithsonian.md` | Automated ball-strike system fan reactions | Sports Technology Symposium, Washington DC | conferences | 2024-10 |

Publication categories in `_config.yml`: Books, Journal Articles (`manuscripts`), Conference Papers (`conferences`).

### Talks (`_talks/`) — 14 files, ALL ACTIVE

**Podcast episodes (7)** — YouTube video discussions of Q's research:

| File | Title (short) | Related publication | Date |
|---|---|---|---|
| `Podcast_ABS_MLB.md` | Robo-Umps: baseball authenticity on Reddit | Smithsonian.md | 2024-11-01 |
| `Podcast_B50.md` | The Break 50 Phenomenon | B50.md / JRCS_Trump.md | 2025-09-30 |
| `Podcast_EXP.md` | College football game day experience | SMR_experience.md | 2024-09-27 |
| `Podcast_HICSS58.md` | Esports at 2023 Asian Games on X | HICSS58.md | 2024-10-30 |
| `Podcast_Olympics.md` | 2022 Beijing Winter Olympics on X | CS_Olympics.md | 2024-10-28 |
| `Podcast_TS_NFL.md` | NFL's Swift-Kelce Instagram strategy | JSM_TS.md | 2024-11-14 |
| `Podcast_Twitch.md` | TNF co-streaming on Twitch | SMR_costream.md | 2021-06-16 |

**Teaching demos (7)** — QLearning tutorials and conference presentations:

| File | Title (short) | Format | Date |
|---|---|---|---|
| `Teaching_LLM101.md` | QLearning: LLM 101 (GPT-4o in Colab) | YouTube tutorial | 2025-04-04 |
| `Teaching_NASSM_AI.md` | NASSM Conversations: Applied AI in Sport Mgmt | Canva slides | 2025-03-03 |
| `Teaching_NASSM_NLP.md` | NASSM Workshop: NLP4ALL (Zeigler Lectures) | Canva slides + GitHub repo | 2025-05-29 |
| `Teaching_NLP.md` | QLearning: NLP 101 (sentiment analysis) | YouTube tutorial | 2025-03-03 |
| `Teaching_SMA_HAI.md` | SMA Symposium: Human-AI Collaboration | Canva slides + GitHub repo | 2025-10-23 |
| `Teaching_TS_NFL.md` | QLearning: Swift-Kelce Instagram case study | YouTube tutorial + slides | 2024-12-02 |
| `Teaching_Agents.md` | QLearning: From Chatbots to Agents | YouTube tutorial | 2026-03-04 |

### Portfolio (`_portfolio/`) — 7 files, ALL ACTIVE

AI-generated art and creative projects:

| File | Title | Tool | Image(s) |
|---|---|---|---|
| `City.md` | 3D City Landmark Weather Visualization | Nano Banana Pro | `SM_FJ.jpeg`, `XM_FJ.jpeg`, `SH.jpeg`, `Athens_GA.jpeg`, `BR_LA.jpeg`, `Bloomington_IN.jpeg` |
| `Logo_Q.md` | Brand Logos for Dr. Q | Ideogram + Canva | `Logo_Q.png`, `Logo_Q_SB.png`, and variants (`_B`, `_Horizontal`, `_OB`, `_W`) |
| `Sticker_Q.md` | Social Sticker (chibi LINE-style) | Nano Banana Pro | `Ty_Q_EN.jpeg`, `Ty_Q_CN.jpeg` |
| `Tracy_cute.md` | Whispers of Dawn in Tracy's Smile | ComfyUI-InstantID | `Tracy_cute1.png` |
| `Ty_football.md` | Tyreal's Gridiron Dream | ComfyUI-InstantID | `Q.png` |
| `XL.md` | Xiaoli's Radiant Moment: Portrait of a Mother | ComfyUI-InstantID | `XL.png` |
| `XSP.md` | Siping's Poem: Portrait of a Father | ComfyUI-InstantID | `SP8.png` |

### Teaching (`_teaching/`) — 2 files, PLACEHOLDER (theme template)

| File | Notes |
|---|---|
| `2014-spring-teaching-1.md` | Template from Academic Pages theme |
| `2015-spring-teaching-2.md` | Template from Academic Pages theme |

### Blog Posts (`_posts/`) — 5 files, PLACEHOLDER (theme template)

| File | Notes |
|---|---|
| `2012-08-14-blog-post-1.md` | Template |
| `2013-08-14-blog-post-2.md` | Template |
| `2014-08-14-blog-post-3.md` | Template |
| `2015-08-14-blog-post-4.md` | Template |
| `2199-01-01-future-post.md` | Template (future-dated) |

### Pages (`_pages/`) — 18 files

**Active pages:**

| File | Permalink | Purpose |
|---|---|---|
| `about.md` | `/` | Homepage — bio, research areas, open resource links |
| `cv.md` | `/cv/` | Academic CV — appointments, education, work in progress, skills |
| `publications.html` | `/publications/` | Publication listing (grouped by category) |
| `talks.html` | `/talks/` | Talks listing |
| `portfolio.html` | `/portfolio/` | Portfolio gallery |
| `teaching.html` | `/teaching/` | Teaching listing |
| `404.md` | `/404.html` | Custom 404 page |
| `sitemap.md` | `/sitemap/` | HTML sitemap |
| `terms.md` | `/terms/` | Terms and privacy |

**Archive generators:**

| File | Purpose |
|---|---|
| `category-archive.html` | Posts by category |
| `collection-archive.html` | All collections |
| `page-archive.html` | All pages |
| `tag-archive.html` | Posts by tag |
| `year-archive.html` | Posts by year |
| `talkmap.html` | Talk locations map (disabled via `talkmap_link: false`) |

**Template / unused:**

| File | Notes |
|---|---|
| `archive-layout-with-content.md` | Theme example page |
| `markdown.md` | Markdown formatting guide |
| `non-menu-page.md` | Theme example of a non-nav page |

## Images Directory

All images live in `images/`. Grouped by purpose:

**Research infographics** (used in publications):
- `B50.png`, `B50_INFO.jpeg` — Break 50 / Trump golf
- `WG_INFO.jpeg` — Winter Olympics / Games
- `ESPORTS_INFO.jpg` — Esports spectator motivation
- `ESPORTS_GAMIFICATION_INFO.jpg` — Gamification in esports
- `EXP_INFO.jpeg` — Stadium experience / LLM
- `TS_INFO.png` — Taylor Swift & NFL
- `TWITCH_SPORTS_INFO.jpg` — Twitch co-streaming

**Teaching demo thumbnails:**
- `LLM101.png` — LLM 101 tutorial
- `NLP4ALL.png` — NLP4ALL workshop
- `QLearning101.png` — QLearning series

**Portfolio / portraits:**
- `Q.png` — Tyreal football portrait
- `Tracy_cute1.png` — Tracy portrait
- `XL.png` — Xiaoli portrait
- `SP8.png` — Siping portrait
- `Ty_Q_EN.jpeg`, `Ty_Q_CN.jpeg` — Stickers (English/Chinese)

**Brand logos:**
- `Logo_Q.png`, `Logo_Q_B.png`, `Logo_Q_Horizontal.png`, `Logo_Q_OB.png`, `Logo_Q_SB.png`, `Logo_Q_W.png`

**City weather visualizations:**
- `SM_FJ.jpeg` (Sanming), `XM_FJ.jpeg` (Xiamen), `SH.jpeg` (Shanghai), `Athens_GA.jpeg`, `BR_LA.jpeg` (Baton Rouge), `Bloomington_IN.jpeg`

**Site assets (theme defaults):**
- `Ty.png` — Author avatar (sidebar)
- `bio-photo.jpg`, `bio-photo-2.jpg`, `profile.jpg` — Stock/theme bios
- `site-logo.png`, `homepage.png` — Site branding
- `favicon.ico`, `safari-pinned-tab.svg`, `browserconfig.xml`, `manifest.json`, `mstile-*.png` — Favicon/PWA
- `500x300.png` — Default teaser
- Other theme stock images: `foo-bar-identity*.jpg`, `editing-talk.png`, `paragraph-*.png`, `image-alignment-*.jpg`, `3953273590_704e3899d5_m.jpg`

## Configuration Files

| File | Purpose |
|---|---|
| `_config.yml` | Site metadata, author info, collections, plugins, publication categories, defaults |
| `_data/navigation.yml` | Header nav links: CV, Research Highlights, Teaching Demos, Fun Stuff |
| `Gemfile` | Ruby deps (`jekyll`, `github-pages`, `webrick`) |
| `package.json` | Node deps for JS bundling (`jquery`, `fitvids`, `magnific-popup`) |
| `Dockerfile` | Docker build for local dev |

## Content Workflow

**Add a new publication:**
1. Create `_publications/<slug>.md` with YAML front matter: `title`, `collection: publications`, `category` (manuscripts/conferences/books), `permalink`, `excerpt`, `date`, `venue`, optionally `paperurl`
2. Add an infographic image to `images/` if needed, reference with `<img src='/images/...'>`
3. Or: add a row to `markdown_generator/publications.tsv` and run `publications.py`

**Add a new talk (podcast or teaching demo):**
1. Create `_talks/<Podcast_or_Teaching>_<slug>.md` with front matter: `title`, `collection: talks`, `excerpt`, `type: "Talk"`, `permalink`, `date`
2. Embed YouTube iframe or Canva slides in the body

**Add a portfolio item:**
1. Create `_portfolio/<slug>.md` with front matter: `title`, `excerpt` (include thumbnail img tag), `collection: portfolio`, `permalink`
2. Add images to `images/`, reference in body

## Deployment

Push to `master` branch. GitHub Pages builds and deploys automatically.
