# 🚢 TransitPro CI — SaaS de Gestion de Transit & Douane

Application complète de gestion de transit douanier pour la Côte d'Ivoire.

---

## 🗂️ Structure du projet

```
transitpro/
├── pages/
│   ├── index.js               ← Tableau de bord
│   ├── dossiers/
│   │   ├── index.js           ← Liste des dossiers
│   │   └── [id].js            ← Détail d'un dossier
│   ├── clients/
│   │   ├── index.js           ← Liste des clients
│   │   └── [id].js            ← Fiche client
│   ├── calcul.js              ← Calculateur douanier
│   ├── documents/index.js     ← Génération PDF
│   ├── notifications/index.js ← WhatsApp / SMS
│   └── api/
│       ├── stats.js
│       ├── dossiers/
│       ├── clients/
│       ├── documents/
│       └── notifications/
├── components/
│   ├── Layout.js              ← Sidebar + navigation
│   └── Toast.js               ← Notifications UI
├── lib/
│   ├── supabase.js            ← Client base de données
│   ├── calcul.js              ← Calcul droits douaniers
│   ├── pdf.js                 ← Génération PDF (jsPDF)
│   └── messages.js            ← Templates WhatsApp/SMS
├── styles/globals.css
├── supabase_schema.sql        ← Schéma base de données
└── .env.example               ← Variables d'environnement
```

---

## 🚀 Installation et déploiement

### Étape 1 — Prérequis
- [Node.js 18+](https://nodejs.org)
- Compte [Supabase](https://supabase.com) (gratuit)
- Compte [Twilio](https://twilio.com) (pour WhatsApp/SMS réels)
- Compte [Vercel](https://vercel.com) (pour déploiement, gratuit)

### Étape 2 — Cloner et installer

```bash
cd transitpro
npm install
```

### Étape 3 — Configurer Supabase

1. Créez un projet sur [supabase.com](https://supabase.com)
2. Allez dans **SQL Editor**
3. Copiez et exécutez le contenu de `supabase_schema.sql`
4. Allez dans **Settings > API** et copiez :
   - `Project URL`
   - `anon public key`
   - `service_role key`

### Étape 4 — Variables d'environnement

```bash
cp .env.example .env.local
```

Éditez `.env.local` et remplissez :

```env
NEXT_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...
SUPABASE_SERVICE_KEY=eyJ...

# Twilio (pour WhatsApp/SMS réels)
TWILIO_ACCOUNT_SID=ACxxxxxxxx
TWILIO_AUTH_TOKEN=xxxxxxxx
TWILIO_WHATSAPP_FROM=whatsapp:+14155238886
TWILIO_SMS_FROM=+1XXXXXXXXXX

AGENT_WHATSAPP=+2250787289709
```

### Étape 5 — Lancer en développement

```bash
npm run dev
```

Ouvrez [http://localhost:3000](http://localhost:3000)

### Étape 6 — Déployer sur Vercel (production)

```bash
npm install -g vercel
vercel
```

Ou via GitHub :
1. Pushez sur GitHub
2. Connectez le repo sur [vercel.com](https://vercel.com)
3. Ajoutez les variables d'environnement dans Vercel Dashboard
4. Déployez 🚀

---

## 📱 Configuration WhatsApp réel (Twilio)

### Option A — WhatsApp Sandbox (test gratuit)
1. Créez un compte sur [twilio.com](https://twilio.com)
2. Allez dans **Messaging > Try it Out > Send a WhatsApp message**
3. Suivez les instructions du sandbox
4. Votre numéro client doit envoyer le code d'activation

### Option B — WhatsApp Business API (production)
1. Soumettez votre numéro +225 0787289709 pour approbation Meta
2. Suivez le guide : [twilio.com/whatsapp](https://www.twilio.com/whatsapp)
3. Délai d'approbation : 1 à 7 jours

---

## 🔑 Fonctionnalités

| Module | Description |
|--------|-------------|
| 📊 **Tableau de bord** | Stats temps réel, dossiers récents, actions rapides |
| 📁 **Dossiers** | CRUD complet, filtres par statut, changement de statut |
| 🧮 **Calcul douane** | Calcul auto droits, TVA, transport, honoraires |
| 👥 **Clients** | Fiches clients, historique opérations, stats CA |
| 📄 **Documents** | Factures/Reçus/Devis en PDF téléchargeables |
| 💬 **Notifications** | WhatsApp + SMS via Twilio, aperçu live, historique |

---

## 💰 Coûts estimés

| Service | Coût |
|---------|------|
| Supabase (Free tier) | 0 FCFA/mois |
| Vercel (Hobby) | 0 FCFA/mois |
| Twilio WhatsApp | ~35 FCFA/message |
| Twilio SMS | ~20 FCFA/SMS |

**Total minimum : 0 FCFA/mois** pour commencer !

---

## 🛠️ Support

Agent TransitPro CI : **+225 0787289709**
