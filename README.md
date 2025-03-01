# React 開発環境 (Docker)

このプロジェクトは、Docker を使用して React の開発環境を構築するための設定です。学習用途のため、シンプルな構成にしており、Mac・Windows(WSL)の環境依存なく進められることを目的としています。

Vite はコンテナ内で手動インストールする前提となっており、React プロジェクトの作成からセットアップまで自分で行うことで学習効果を高められるように設計されています。

## 📂 ファイル構成

```
project-root/
│── compose.yaml
│── Dockerfile
└── app/  # Reactプロジェクトのコードを配置
```

---

## 🚀 環境構築手順

### **1. リポジトリのクローン & ディレクトリ作成**

まず、このリポジトリをクローンしてください。
```sh
git clone git@github.com:yama/react-docker-simple.git
cd react-docker-simple.git
mkdir app  # Reactアプリ用のディレクトリを作成
```

### **2. `.env` ファイルの作成 (オプション)**

#### **ホストの `UID` / `GID` を確認する**
以下のコマンドを実行し、現在のユーザーID (`UID`) とグループID (`GID`) を確認してください。
```sh
id -u  # UID を確認
id -g  # GID を確認
```

#### **`UID` / `GID` が `1000` でない場合、`.env` を作成**
もし `UID` または `GID` が `1000` でない場合、以下の手順で `.env` を作成してください。

```sh
echo "UID=$(id -u)" > .env
echo "GID=$(id -g)" >> .env
```

この `.env` ファイルにより、コンテナ内のファイル権限がホストユーザーと一致するようになります。

### **3. Dockerコンテナのビルド & 起動**

```sh
docker compose up -d --build
```

### **4. コンテナに入る**

```sh
docker exec -it react-app bash
```

### **5. Vite プロジェクトの作成 (コンテナ内で実行)**

```sh
npm create vite@latest
```

### **6. 依存関係のインストール (コンテナ内で実行)**

```sh
npm install
```

### **7. 開発サーバーの起動 (コンテナ内でバックグラウンド実行)**

```sh
nohup npm run dev -- --host > /dev/null 2>&1 &
```

### **8. ブラウザでアクセス**

[http://localhost](http://localhost) にアクセスすると、React アプリが表示されます。

---

## 🔧 設定詳細

### **Dockerfile の説明**

- `node:lts` の最新 LTS 版を使用。
- `bash` をインストール。
- `CMD ["bash"]` により、デフォルトのシェルを `bash` に設定。

### **compose.yml の説明**

- `volumes` により `app/` をコンテナと同期。
- `user: "${UID:-1000}:${GID:-1000}"` により、ホストユーザーの UID/GID を反映。
- `stdin_open: true` & `tty: true` により、対話的なシェル操作を可能に。

---

## 🛑 コンテナの停止 & 削除

### **コンテナを停止する**

```sh
docker compose down
```

### **コンテナとボリュームを完全削除**

```sh
docker compose down -v
```

---

## 🎯 まとめ

- **Docker で React の開発環境を構築**
- **ホストの `app/` を編集しながらコンテナ内で実行**
- **`UID:GID` を指定して権限問題を解決**
- **Vite を手動でインストールし、環境構築を学習できる**

この環境を使えば、手軽に React の開発を学習できます！ 🚀

