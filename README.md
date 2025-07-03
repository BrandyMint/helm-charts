# BrandyMint official's HELM Charts

[![Release Charts](https://github.com/BrandyMint/helm-charts/actions/workflows/release.yml/badge.svg)](https://github.com/BrandyMint/helm-charts/actions/workflows/release.yml)

Этот репозиторий содержит типовой helm-chart для Ruby On Rails приложений используемых в
BrandyMint

# Использование

```sh
helm repo add brandymint https://brandymint.github.io/helm-charts/
helm install MyApp brandymint/ror
```

# Изменения и публикация чартов

1. Изменить версию чарта в ./charts/ror/Chart.yaml
2. make package upload

Для публикации в виде чарта изменений достаточно выпустить новый релиз - https://github.com/BrandyMint/helm-charts/releases/new
