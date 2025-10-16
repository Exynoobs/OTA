---
layout: default
title: LineageOS builds by Exynoobs
---

# Supported devices

{% assign sorted_pages = site.pages | sort: 'title' %}

{% for page in sorted_pages %}
{% if page.title and page.url and page.url contains "/devices/" %}
{% unless page.url contains "-install" %}

- [{{ page.title }} ({{ page.codename }})]({{ page.url | relative_url }})
  {% endunless %}
  {% endif %}
  {% endfor %}
