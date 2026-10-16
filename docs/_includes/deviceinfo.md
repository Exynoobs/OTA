{%- assign device = site.data.devices[page.codename] -%}
{%- assign install_url = "/devices/" | append: page.codename | append: "-install.html" -%}
{%- assign upgrade_url = "/devices/" | append: page.codename | append: "-upgrade.html" -%}
{%- assign has_install = site.pages | where: "url", install_url | size -%}
{%- assign has_upgrade = site.pages | where: "url", upgrade_url | size -%}
{%- assign ota_url = site.lineage_ota_base_url | append: page.codename | append: ".json" -%}
{%- fetch builds_raw ota_url -%}
{%- json builds builds_raw -%}
{%- assign build = builds.response[0] -%}
<section class="device-hero">
<div class="device-image"><img src="{{ "/images/" | append: page.codename | append: ".png" | relative_url }}" alt="{{ page.title }}"></div>
<div>
<span class="eyebrow">{{ device.chipset | split: "(" | first }}</span>
<h1>{{ page.title }}</h1>
<div class="lead"><span class="badge">{{ page.codename }}</span><span>{{ device.models }}</span></div>
<div class="actions">
<a class="btn" href="{{ "/changes/" | append: page.codename | append: ".html" | relative_url }}">Changelog</a>
{%- if has_install > 0 %}
<a class="btn" href="{{ install_url | relative_url }}">Install instructions</a>
{%- endif %}
{%- if has_upgrade > 0 %}
<a class="btn" href="{{ upgrade_url | relative_url }}">Upgrade instructions</a>
{%- endif %}
</div>
<div class="build-card">
{%- if build %}
{%- assign recovery_url = build.url | replace: 'UNOFFICIAL', 'recovery' | replace: '.zip', '.img' -%}
{%- assign recovery_name = build.filename | replace: 'UNOFFICIAL', 'recovery' | replace: '.zip', '.img' -%}
{%- assign vbmeta_url = build.url | replace: build.filename, 'vbmeta.img' %}
<div class="build-card-head"><strong>Latest build · LineageOS {{ build.version }}</strong><span>{{ build.datetime | date: "%B %-d, %Y" }} · {{ build.size | divided_by: 1073741824.0 | round: 2 }} GB</span></div>
<div class="dl-row"><span class="dl-label">ROM</span><a class="dl-file" href="{{ build.url }}">{{ build.filename }}</a><a class="dl-sha" href="{{ build.url }}.sha256">sha256</a></div>
<div class="dl-row"><span class="dl-label">Recovery</span><a class="dl-file" href="{{ recovery_url }}">{{ recovery_name }}</a><a class="dl-sha" href="{{ recovery_url }}.sha256">sha256</a></div>
{%- if has_install > 0 %}
<div class="dl-row"><span class="dl-label">vbmeta</span><a class="dl-file" href="{{ vbmeta_url }}">vbmeta.img</a><a class="dl-sha" href="{{ vbmeta_url }}.sha256">sha256</a></div>
{%- endif %}
{%- else %}
<div class="dl-row"><span class="empty">No builds found for {{ page.codename }}.</span></div>
{%- endif %}
</div>
</div>
</section>
<section>
<h2 class="section-title">Device specifications</h2>
<div class="specs">
<div class="spec"><div class="spec-label">Chipset</div><div class="spec-value">{{ device.chipset }}</div></div>
<div class="spec"><div class="spec-label">CPU</div><div class="spec-value">{{ device.cpu }}</div></div>
<div class="spec"><div class="spec-label">GPU</div><div class="spec-value">{{ device.gpu }}</div></div>
<div class="spec"><div class="spec-label">RAM</div><div class="spec-value">{{ device.ram }}</div></div>
<div class="spec"><div class="spec-label">Storage</div><div class="spec-value">{{ device.storage }}</div></div>
<div class="spec"><div class="spec-label">Shipped Android version</div><div class="spec-value">{{ device.shipped_version }}</div></div>
{%- if device.display_outer and device.display_inner %}
<div class="spec"><div class="spec-label">Display (outer)</div><div class="spec-value">{{ device.display_outer }}</div></div>
<div class="spec"><div class="spec-label">Display (inner)</div><div class="spec-value">{{ device.display_inner }}</div></div>
{%- else %}
<div class="spec"><div class="spec-label">Display</div><div class="spec-value">{{ device.display }}</div></div>
{%- endif %}
<div class="spec"><div class="spec-label">Battery</div><div class="spec-value">{{ device.battery }}</div></div>
<div class="spec spec-wide"><div class="spec-label">Rear camera</div><div class="spec-value">{{ device.rear_cameras | join: "<br>" }}</div></div>
<div class="spec"><div class="spec-label">Front camera</div><div class="spec-value">{{ device.front_cameras | join: "<br>" }}</div></div>
{%- if device.dimensions_folded and device.dimensions_unfolded %}
<div class="spec"><div class="spec-label">Dimensions (folded)</div><div class="spec-value">{{ device.dimensions_folded }}</div></div>
<div class="spec"><div class="spec-label">Dimensions (unfolded)</div><div class="spec-value">{{ device.dimensions_unfolded }}</div></div>
{%- else %}
<div class="spec"><div class="spec-label">Dimensions</div><div class="spec-value">{{ device.dimensions }}</div></div>
{%- endif %}
{%- if device.sim %}
<div class="spec"><div class="spec-label">SIM</div><div class="spec-value">{{ device.sim }}</div></div>
{%- endif %}
{%- if device.microsd %}
<div class="spec"><div class="spec-label">MicroSD</div><div class="spec-value">{{ device.microsd }}</div></div>
{%- endif %}
{%- if device.fingerprint %}
<div class="spec"><div class="spec-label">Fingerprint</div><div class="spec-value">{{ device.fingerprint }}</div></div>
{%- endif %}
<div class="spec"><div class="spec-label">Sensors</div><div class="spec-value">{{ device.sensors }}</div></div>
</div>
</section>
