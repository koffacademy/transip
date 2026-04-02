-- =============================================
-- TransitPro CI — Schéma base de données Supabase
-- Copiez et exécutez ce SQL dans Supabase > SQL Editor
-- =============================================

-- Table des clients
CREATE TABLE clients (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  nom TEXT NOT NULL,
  telephone TEXT,
  email TEXT,
  adresse TEXT,
  ville TEXT DEFAULT 'Abidjan',
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table des dossiers
CREATE TABLE dossiers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  numero TEXT UNIQUE NOT NULL,
  client_id UUID REFERENCES clients(id),
  description TEXT NOT NULL,
  valeur_cif NUMERIC NOT NULL DEFAULT 0,
  poids NUMERIC DEFAULT 0,
  pays_origine TEXT DEFAULT 'Chine',
  port TEXT DEFAULT 'Port d\'Abidjan',
  type_transport TEXT DEFAULT 'Maritime',
  statut TEXT DEFAULT 'en_cours' CHECK (statut IN ('en_cours','livre','bloque')),
  date_arrivee DATE,
  droits_douane NUMERIC DEFAULT 0,
  tva NUMERIC DEFAULT 0,
  frais_transport NUMERIC DEFAULT 0,
  frais_magasinage NUMERIC DEFAULT 0,
  honoraires NUMERIC DEFAULT 0,
  total_frais NUMERIC DEFAULT 0,
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table des documents générés
CREATE TABLE documents (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  numero TEXT UNIQUE NOT NULL,
  type TEXT NOT NULL CHECK (type IN ('facture','recu','devis')),
  dossier_id UUID REFERENCES dossiers(id),
  client_id UUID REFERENCES clients(id),
  montant_ht NUMERIC NOT NULL DEFAULT 0,
  tva NUMERIC DEFAULT 18,
  montant_ttc NUMERIC NOT NULL DEFAULT 0,
  mode_paiement TEXT DEFAULT 'Virement bancaire',
  statut TEXT DEFAULT 'emis' CHECK (statut IN ('emis','paye','annule')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Table des notifications envoyées
CREATE TABLE notifications (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  client_id UUID REFERENCES clients(id),
  dossier_id UUID REFERENCES dossiers(id),
  type_message TEXT NOT NULL,
  canal TEXT DEFAULT 'whatsapp' CHECK (canal IN ('whatsapp','sms','email')),
  contenu TEXT NOT NULL,
  statut TEXT DEFAULT 'envoye',
  sid_twilio TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Séquences pour numérotation auto
CREATE SEQUENCE IF NOT EXISTS seq_dossier START 100;
CREATE SEQUENCE IF NOT EXISTS seq_facture START 1;
CREATE SEQUENCE IF NOT EXISTS seq_recu START 1;
CREATE SEQUENCE IF NOT EXISTS seq_devis START 1;

-- Données de démo
INSERT INTO clients (nom, telephone, email, adresse) VALUES
  ('SIFCA Group', '+22527202122', 'transit@sifca.ci', 'Zone Industrielle, Abidjan'),
  ('Nestlé Côte d''Ivoire', '+22527213040', 'supply@nestle.ci', 'Treichville, Abidjan'),
  ('CIE', '+22527246677', 'logistique@cie.ci', 'Plateau, Abidjan'),
  ('Orange CI', '+22527201020', 'achats@orange.ci', 'Cocody, Abidjan'),
  ('MTN CI', '+22527223344', 'logistique@mtn.ci', 'Marcory, Abidjan');

-- RLS (Row Level Security) — activer si multi-utilisateurs
-- ALTER TABLE clients ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE dossiers ENABLE ROW LEVEL SECURITY;
