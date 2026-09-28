---
layout: Post
permalink: /
title: Кирилл Улитин
---
<p>
  <strong>Кирилл Улитин</strong><br>
  15+ лет в UX, исследованиях и дизайне цифровых продуктов.<br/>ex-руководитель направления UX & Research в МойОфис: выстроил исследования и анализ в команде из 50 дизайнеров.<br/>Глава программного комитета ResearchExpo, приглашённый преподаватель ВШЭ.
<span class="small-link"><a href="/about">подробнее</a></span>
</p>

<h3>Открыт к предложениям</h3>
<p>
    Открыт к ролям уровня Head / Lead / Principal в UX, исследованиях и дизайне. Интересны сложные B2B/B2C продукты, инструменты, AI.
</p>
<div class="card-grid">
  <a href="/CV_Ulitin_Kirill_Head_UX_Research.pdf" class="card">
    <h4>Head of UX & Research</h4>
    <p>Строю и масштабирую функцию исследований. Команда, стратегия, процессы, метрики. Смотреть резюме...</p>
  </a>

    <a href="/CV_Ulitin_Kirill_Principal_Researcher.pdf" class="card">
    <h4>Principal Researcher</h4>
    <p>Углубляю методологию, влияю через данные. 400+ исследований, 70 лично. ИИ, кач/колич, аналитка Смотреть резюме...</p>
  </a>

</div>

<h3>Текущий статус</h3>
<div>
  {% assign now_page = site.pages | where: "permalink", "/now" | first %}
  {% capture content_with_date %}{{ now_page.content }} <span class="small-link"><a href="/now">{{ now_page.date | date: "%d %b %Y" }}</a></span>{% endcapture %}
  {{ content_with_date | markdownify }}
</div>

<div class="card-grid">

  <a href="https://t.me/ulitin_ru" class="card">
    <h4>Телеграм-блог</h4>
    <p>Веду Telegram-блог с заметками про AI, Product, UX, Research. Публикую записи клуба FWR</p>
  </a>
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


</div>




