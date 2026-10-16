---
layout: default
title: LineageOS builds by Exynoobs
---

{%- assign featured = "e3q,b5q,q5q,dm1q" | split: "," -%}
{%- assign sorted_pages = "" | split: "" -%}
{%- for codename in featured -%}
  {%- assign device_url = "/devices/" | append: codename | append: ".html" -%}
  {%- assign match = site.pages | where: "url", device_url -%}
  {%- assign sorted_pages = sorted_pages | concat: match -%}
{%- endfor -%}
{%- assign alphabetical = site.pages | sort: 'codename' -%}
{%- for page in alphabetical -%}
  {%- unless featured contains page.codename -%}
    {%- assign match = site.pages | where: "url", page.url -%}
    {%- assign sorted_pages = sorted_pages | concat: match -%}
  {%- endunless -%}
{%- endfor -%}
<section class="hero">
<span class="eyebrow">Unofficial LineageOS</span>
<h1>Builds for Samsung Galaxy devices</h1>
<p>Pick your device for the latest build, changelog and install instructions.</p>
</section>
<div class="device-grid">
{%- for page in sorted_pages %}
{%- if page.title and page.url and page.url contains "/devices/" %}
{%- unless page.url contains "-install" or page.url contains "-upgrade" %}
{%- assign device = site.data.devices[page.codename] %}
<a class="device-card" href="{{ page.url | relative_url }}">
<div class="device-card-img"><img src="{{ "/images/" | append: page.codename | append: ".png" | relative_url }}" alt="" loading="lazy"></div>
<div class="device-card-body">
<div class="device-card-title">{{ page.title }}</div>
<div class="device-card-meta"><span class="badge">{{ page.codename }}</span><span class="device-card-chip">{{ device.chipset | split: "(" | first }}</span></div>
</div>
</a>
{%- endunless %}
{%- endif %}
{%- endfor %}
</div>
