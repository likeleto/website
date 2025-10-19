---
layout: Post
permalink: /
title: Кирилл Улитин
---
<p>
  <strong>Кирилл Улитин</strong><br>
  Руководитель направления UX & Research в МойОфис. Развиваю исследовательские и аналитические практики в команде из 50 UX-дизайнеров. <span class="small-link"><a href="/about">подробнее</a></span>
</p>

<div class="card-grid">
  <a href="/articles" class="card">
    <h4>Статьи</h4>
    <p>Список моих статей.</p>
  </a>
  <a href="/talks" class="card">
    <h4>Выступления</h4>
    <p>Список моих выступлений.</p>
  </a>
<!--   <a href="/notes" class="card">
    <h4>Заметки</h4>
    <p>Это долгоиграющая попытка перейти наконец на Обсидиан для их ведения.</p>
  </a>
  <a href="/logs" class="card">
    <h4>Полезное</h4>
    <p>Всякие ссылки, которые нужно куда то положить.</p>
  </a>  -->

  <a href="https://t.me/ulitin_ru" class="card">
    <h4>Телеграм-блог</h4>
    <p>Веду Telegram-блог с заметками про исследования и не только.</p>
  </a>
</div>


<h3>Текущий статус</h3>
<div>
  {% assign now_page = site.pages | where: "permalink", "/now" | first %}
  {% capture content_with_date %}{{ now_page.content }} <span class="small-link"><a href="/now">{{ now_page.date | date: "%d %b %Y" }}</a></span>{% endcapture %}
  {{ content_with_date | markdownify }}
</div>

