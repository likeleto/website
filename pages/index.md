---
layout: Post
permalink: /
title: Jekyll Garden
---
<p>
  <strong>Hiran Venugopalan</strong><br>
  Product and type designer with 14 years of building and leading design teams. Currently shaping product experiences at  <a href="https://www.kaleyra.com/">Kaleyra</a>. Builder and collaborator on tools, systems, and ideas. Mentor to designers and product folks. Also, Barback at <a href="https://www.instagram.com/moonbowl.in/">Moonbowl</a>, and occasional host of coffee workshops. <span class="small-link"><a href="/about">more</a></span>
</p>

<div class="card-grid">
  <a href="/notes" class="card">
    <h4>Working Notes</h4>
    <p>Ongoing thoughts on design, systems, and internet patterns.</p>
  </a>
  <a href="/projects" class="card">
    <h4>Projects</h4>
    <p>Things I've built, tried, or still tinkering with.</p>
  </a>
  <a href="https://found.hiran.in" class="card">
    <h4>The Found</h4>
    <p>A visual archive of past work and sketches.</p>
  </a>
  <a href="/logs" class="card">
    <h4>Books & Bookmarks</h4>
    <p>Stuff I’ve read, watched, heard, or bookmarked lately.</p>
  </a>
  <a href="https://hiran.substack.com/" class="card">
    <h4>Newsletter</h4>
    <p>Every so often, a short note with a bit of <i>This&That.</i></p>
  </a>
  <a href="/contact" class="card">
    <h4>Coaching</h4>
    <p>1:1 conversations for clarity, growth, and better work.</p>
  </a>
  
</div>


<h3>Now</h3>
<div>
  {% assign now_page = site.pages | where: "permalink", "/now" | first %}
  {% capture content_with_date %}{{ now_page.content }} <span class="small-link"><a href="/now">{{ now_page.date | date: "%d %b %Y" }}</a></span>{% endcapture %}
  {{ content_with_date | markdownify }}
</div>

<h3>Collaborate</h3>
<p>
Always happy to <a href="/contact">connect</a> with people - whether you're working on something new, figuring out your next step, or just want to swap notes over coffee. I mentor early-stage designers, jam with builders, and enjoy slow conversations about how we work and learn. <span class="small-link"><a href="/contact">hiran.v@gmail.com</a></span>
</p>