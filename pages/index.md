---
layout: Post
permalink: /
title: Jekyll Garden
---
<h3>Intro</h3>
<p>
  <strong>Hiran Venugopalan</strong><br>
  Product and type designer with 14 years of building and leading design teams. Currently crafting digital experiences at <a href="https://www.kaleyra.com/">Kaleyra</a>
</p>

<h3>ToC</h3>
<div class="toc-list">
  <div class="toc-col">
    <div><a href="/notes">Working Notes</a> <span class="toc-count">{{ site.notes | where_exp: "note", "note.category == 'Notes'" | size }}</span></div>
    <div><a href="/logs">Logs</a> <span class="toc-count">{{ site.notes | where_exp: "note", "note.category == 'Logs'" | size }}</span></div>
    <div><a href="/web-found">WebFound</a> <span class="toc-count">{{ site.notes | where_exp: "note", "note.category == 'WebFound'" | size }}</span></div>
    <div><a href="/topics">Things</a> <span class="toc-count">{{ site.notes | where_exp: "note", "note.category == 'Things'" | size }}</span></div>
  </div>
  <div class="toc-col">
    <div><a href="/about">About</a></div>
    <div><a href="/contact">Coaching</a></div>
    <div><a href="https://found.hiran.in/">The Found*</a></div>
    <div><a href="mailto:hiran.v@gmail.com">Email</a></div>
  </div>
</div>

<h3>Contact</h3>
<p>
I build <i>things</i> and love collaborating on experimental projects. I also mentor designers, founders, and teams on design, strategy, and growth. If you're curious to work together, or explore ideas, <a href="/contact">reach out here</a>. I'm based in Bangalore - happy to meet for a coffee if you're around.
</p>

<h3>Newsletter</h3>
<p>
  Every so often, I send out a short, bite-sized newsletter - quick ideas, tools, and links that sparked something. <a href="https://hiran.substack.com/">Subscribe</a> to stay in the loop.
</p>

<h3>Now</h3>
<div>
  {% assign now_page = site.pages | where: "permalink", "/now" | first %}
  {{ now_page.content | markdownify }}
  {{ now_page.date | date: "%d %b %Y" }}
</div>