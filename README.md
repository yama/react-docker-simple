# React 開発環境 (Docker)

このプロジェクトは、Docker を使用して React の開発環境を構築するための設定です。Vite はコンテナ内で手動インストールする前提となっています。

## 📂 ファイル構成

```
project-root/
│── docker-compose.yml
│── Dockerfile
└── app/  # Reactプロジェクトのコードを配置
```

---

## 🚀 環境構築手順

### **1. リポジトリのクローン & ディレクトリ作成**

```sh
mkdir react-docker && cd react-docker
mkdir app  # Reactアプリ用のディレクトリを作成
```

### **2. ****`.env`**** ファイルの作成 (オプション)**

ホストの `UID` / `GID` を `.env` に保存することで、適切な権限でファイルを作成できます。

```sh
echo "UID=$(id -u)" > .env
echo "GID=$(id -g)" >> .env
```

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
npm create vite@latest . -- --template react-ts
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
- `bash` と `git` をインストール。
- `5173` 番ポートを開放。
- `CMD ["bash"]` により、デフォルトのシェルを `bash` に設定。

### **docker-compose.yml の説明**

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

✅ **Docker で React の開発環境を構築**
✅ **ホストの ****`app/`**** を編集しながらコンテナ内で実行**
✅ **ポート ****`5173`**** で開発サーバーを公開**
✅ **`UID:GID`**** を指定して権限問題を解決**
✅ **Vite の ****`--host`**** 設定で外部アクセス可能に**

この環境を使えば、簡単に React の開発を始められます！ 🚀

