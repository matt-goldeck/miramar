# Miramar
<img width="840" alt="Screenshot 2025-04-25 at 4 47 28 PM" src="https://github.com/user-attachments/assets/65a85e73-1c2f-4212-bdd4-93c44e19d93e" />

[fightertown, usa](https://youtu.be/okyLAKclleo)

Miramar is the home base for Supabase schema migrations for the Afterburner job tracking project.


## 🧰 Tech Stack
* It's just [Supabase](https://supabase.com/) and a GHA

## 🛠️ Local Setup

### 1. Install Supabase CLI
```bash
brew install supabase/tap/supabase
```

### 2. Clone the Repository
```bash
git clone git@github.com:matt-goldeck/miramar.git
cd miramar
```

### 3. Fire up Supabase
```bash
supabase start
```

### 4. Apply migrations
```bash
supabase db reset
```

