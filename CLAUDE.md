# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
Static HTML/CSS portfolio website deployed to AWS using S3 and CloudFront, provisioned with Terraform, and automated via GitHub Actions.

---

## Architecture
Pure HTML5 and CSS3. No JavaScript. No build step. No framework.

---

## Commands
- terraform init
- terraform plan
- terraform apply

---

## Conventions
   - All infrastructure changes go through Terraform — never modify AWS resources manually.
   - No JavaScript in this project.
   - CSS uses mobile-first approach with breakpoints at 900px, 768px, and 600px.
---

## Safety
   - Never put secrets in this file. No API keys, passwords, or AWS credentials.

## Project Structure

```
├── index.html          # Main portfolio page (hero, about, services, courses, books, contact)
├── privacy.html        # Privacy policy page
├── terms.html          # Terms & Conditions page
├── style.css           # All styling (1145 lines, responsive design)
├── images/             # Asset folder
│   ├── logo.png
│   ├── profile.jpg, signature.png
│   ├── image.png       # Hero banner background
│   └── *.jpg           # Course and book thumbnails
└── README.md           # Deployment instructions for DMI students
```

---

## Development

### Preview Locally

Since this is a static site, use any of these approaches:

**Option 1: Python (no installation needed if Python is installed)**
```bash
python -m http.server 8000
# Then visit http://localhost:8000
```

**Option 2: Node.js (if available)**
```bash
npx http-server
# Then visit http://localhost:8080
```

**Option 3: Nginx (to mimic production)**
```bash
sudo apt install nginx
sudo cp -r . /var/www/html/
sudo systemctl start nginx
# Then visit http://localhost
```

### Key Content Areas

- **Hero Banner**: `index.html` lines 57–68 (h1 text and background image)
- **About Section**: `index.html` lines 70–123 (profile image, bio, cards)
- **Services Section**: `index.html` lines 125–226 (3 service cards)
- **Courses Section**: `index.html` lines 230–339 (course grid with Udemy links)
- **Books Section**: `index.html` lines 341–405 (book showcase with Amazon links)
- **Contact Section**: `index.html` lines 485–546 (contact info and form)
- **Footer**: `index.html` lines 550–608 (**ownership proof goes here** for DMI)

### Common Edits

| Task | Location |
|------|----------|
| Update hero text | `index.html:65` |
| Change profile image | `images/profile.jpg` or `index.html` references |
| Add/remove courses | `index.html:236–335` (course-card divs) |
| Update contact info | `index.html:504–532` (contact-item divs) |
| Add ownership proof | `index.html:604` (footer-bottom paragraph) |
| Styling changes | `style.css` (responsive breakpoints at ~1200px desktop, mobile uses hamburger) |

---

## Responsive Design

The site is mobile-first responsive with:
- **Desktop**: Full navigation bar (`.nav-links`)
- **Mobile**: Hamburger menu (`.hamburger`) that toggles `.mobile-menu`
- CSS is not organized by component—styles flow sequentially, so search by class name (e.g., `.courses-grid`, `.book-row`)

---

## Deployment to Production

**On Ubuntu VM with Nginx:**

```bash
# 1. Install Nginx
sudo apt install nginx -y

# 2. Deploy site files to Nginx root
sudo cp -r . /var/www/html/
sudo chown -R www-data:www-data /var/www/html
sudo chmod -R 755 /var/www/html

# 3. Verify Nginx configuration
sudo nginx -t

# 4. Start/enable Nginx
sudo systemctl start nginx
sudo systemctl enable nginx

# 5. Verify deployment
curl http://localhost
```

Access via: `http://<public-ip>`

---

## Important Notes for DMI Students

1. **Ownership Proof (Required)**: Edit the footer footer (`index.html:604`) before deployment. Add a line like:
   ```html
   <p><strong>Deployed by:</strong> [Name] | [Group] | [Date]</p>
   ```
   This must be visible in your screenshot submission.

2. **Keep Live for 24 Hours**: The deployment proof requires the site to remain accessible for the full assignment duration.

3. **External Links**: The site links to external URLs (Udemy courses, Amazon books, YouTube, etc.). These are intentional and part of the portfolio content.

---

## Technical Details

- **No build process**: This is pure HTML/CSS served as-is.
- **External dependencies**: Font Awesome 6.5.0 for icons (loaded from CDN).
- **JavaScript**: Minimal; only for mobile menu toggle and navigation (`onclick` handlers in HTML).
- **File size**: `style.css` is 1145 lines; all styling is in a single file.
- **Accessibility**: Uses semantic HTML (`<nav>`, `<section>`, `<article>`, `<footer>`), Font Awesome icon library, and alt text on images.
