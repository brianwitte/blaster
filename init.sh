#!/bin/bash

# Exit on any error
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}🚀 Setting up Shadow CLJS + Reagent project...${NC}"

# Create project directory structure
echo -e "${YELLOW}📁 Creating directory structure...${NC}"
mkdir -p src/app
mkdir -p public/js
mkdir -p resources/public

# Create package.json
echo -e "${YELLOW}📦 Creating package.json...${NC}"
cat > package.json << 'EOF'
{
  "name": "shadow-reagent-app",
  "version": "1.0.0",
  "description": "A minimal Shadow CLJS + Reagent application",
  "main": "index.js",
  "scripts": {
    "dev": "shadow-cljs watch app",
    "build": "shadow-cljs release app",
    "start": "shadow-cljs start"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0"
  },
  "devDependencies": {
    "shadow-cljs": "^2.25.8"
  }
}
EOF

# Create deps.edn
echo -e "${YELLOW}🔧 Creating deps.edn...${NC}"
cat > deps.edn << 'EOF'
{:deps {org.clojure/clojure {:mvn/version "1.11.1"}
        org.clojure/clojurescript {:mvn/version "1.11.132"}
        reagent/reagent {:mvn/version "1.2.0"}}}
EOF

# Create shadow-cljs.edn
echo -e "${YELLOW}⚙️ Creating shadow-cljs.edn...${NC}"
cat > shadow-cljs.edn << 'EOF'
{:source-paths ["src"]
 :dependencies [[reagent "1.2.0"]]
 :builds {:app {:target :browser
                :output-dir "public/js"
                :asset-path "/js"
                :modules {:main {:init-fn app.core/init!}}}}}
EOF

# Create the main HTML file
echo -e "${YELLOW}🌐 Creating index.html...${NC}"
cat > public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shadow CLJS + Reagent App</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            margin: 0;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        #app {
            background: white;
            border-radius: 10px;
            padding: 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            text-align: center;
            max-width: 500px;
        }
        .counter {
            font-size: 48px;
            font-weight: bold;
            color: #333;
            margin: 20px 0;
        }
        button {
            background: #667eea;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            margin: 0 10px;
            transition: background 0.2s;
        }
        button:hover {
            background: #5a6fd8;
        }
        h1 {
            color: #333;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
    <div id="app">
        <p>Loading...</p>
    </div>
    <script src="/js/main.js"></script>
</body>
</html>
EOF

# Create the main ClojureScript file
echo -e "${YELLOW}🔥 Creating app.cljs...${NC}"
cat > src/app/core.cljs << 'EOF'
(ns app.core
  (:require [reagent.core :as r]
            [reagent.dom :as rdom]))

;; State
(defonce counter (r/atom 0))

;; Components
(defn counter-component []
  [:div
   [:h1 "🎉 Shadow CLJS + Reagent"]
   [:p "Welcome to your ClojureScript app!"]
   [:div.counter @counter]
   [:div
    [:button {:on-click #(swap! counter dec)} "−"]
    [:button {:on-click #(reset! counter 0)} "Reset"]
    [:button {:on-click #(swap! counter inc)} "+"]
    ]
   [:p "Click the buttons to change the counter!"]])

;; Initialize the app
(defn init! []
  (println "Initializing app...")
  (rdom/render [counter-component]
               (.getElementById js/document "app")))

;; Hot reload support
(defn ^:dev/after-load reload! []
  (println "Reloading...")
  (init!))
EOF

# Create .gitignore
echo -e "${YELLOW}📝 Creating .gitignore...${NC}"
cat > .gitignore << 'EOF'
# Dependencies
node_modules/
.shadow-cljs/

# Build outputs
public/js/
target/
.cpcache/

# OS
.DS_Store
Thumbs.db

# Editor
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
*.log
EOF

# Create README
echo -e "${YELLOW}📚 Creating README.md...${NC}"
cat > README.md << 'EOF'
# Shadow CLJS + Reagent App

A minimal ClojureScript application using Shadow CLJS and Reagent.

## Getting Started

1. Install dependencies:
   ```bash
   npm install
   ```

2. Start the development server:
   ```bash
   npm run dev
   ```

3. Open your browser to `http://localhost:8080`

## Available Scripts

- `npm run dev` - Start development server with hot reload
- `npm run build` - Build for production
- `npm start` - Start Shadow CLJS server

## Project Structure

```
├── public/
│   └── index.html          # Main HTML file
├── src/app/
│   └── core.cljs          # Main ClojureScript file
├── shadow-cljs.edn        # Shadow CLJS configuration
├── deps.edn              # Clojure dependencies
└── package.json          # NPM dependencies
```

Happy coding! 🚀
EOF

echo -e "${GREEN}✅ Project setup complete!${NC}"
echo -e "${YELLOW}Next steps:${NC}"
echo "1. cd into your project directory"
echo "2. npm install"
echo "3. npm run dev"
echo "4. Open http://localhost:8080"
echo ""
echo -e "${GREEN}🎉 Happy ClojureScript coding!${NC}"
