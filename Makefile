# Zenn 記事執筆用 Makefile
# テンプレートを基に新規記事作成 + npx zenn コマンドのラッパー

# テンプレート: tool / verify / troubleshoot / idea（省略時は tool）
TEMPLATE ?= tool

.PHONY: init new preview new-article new-book help

# デフォルトターゲット: ヘルプ表示
help:
	@echo "Zenn 記事執筆用コマンド:"
	@echo "  make init         - Zenn を初期化 (articles, books ディレクトリ作成)"
	@echo "  make new          - テンプレートを基に新規記事を作成 (SLUG 必須)"
	@echo "  make new-article  - 上記のエイリアス"
	@echo "  make new-book     - 新規本のひな形を作成"
	@echo "  make preview      - ブラウザでプレビューを起動"
	@echo ""
	@echo "テンプレートを基に記事を作成する例:"
	@echo "  make new SLUG=my-article"
	@echo "  make new SLUG=my-article TEMPLATE=verify"
	@echo "  make new SLUG=my-article TEMPLATE=troubleshoot"
	@echo "  make new SLUG=my-article TEMPLATE=idea"
	@echo ""
	@echo "TEMPLATE: tool | verify | troubleshoot | idea (省略時: tool)"

# Zenn を初期化
init:
	npx zenn init

# テンプレートを基に新規記事を作成（SLUG 必須、TEMPLATE は省略時 tool）
# 例: make new SLUG=my-post
# 例: make new SLUG=my-post TEMPLATE=idea
new: new-article

new-article:
	@test -n "$(SLUG)" || (echo "Error: SLUG= を指定してください. 例: make new SLUG=my-article"; exit 1)
	cp template/temp_$(TEMPLATE).md articles/$(SLUG).md
	@echo "Created articles/$(SLUG).md from template temp_$(TEMPLATE).md"

# 新規本を作成（SLUG を指定可能）
# 例: make new-book SLUG=my-book
new-book:
	npx zenn new:book $(if $(SLUG),--slug $(SLUG))

# プレビューサーバーを起動（http://localhost:8000）
preview:
	npx zenn preview
