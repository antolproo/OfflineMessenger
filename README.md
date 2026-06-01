# OfflineMessenger

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

> [!IMPORTANT]
> **Crisis communication resilience deliverable.** This repository serves as a decentralized background intellectual property framework for localized emergency communication ecosystems.

---

## English Section

### Tagline
*Offline peer-to-peer mesh messaging for crisis scenarios — no internet, no servers, no infrastructure required.*

### What it does
OfflineMessenger is a secure, decentralized messaging application engineered specifically for scenarios where traditional communication infrastructure fails. 
* **Bluetooth Mesh Networking:** Operates completely offline, routing encrypted packets node-to-node directly through local user devices.
* **Zero-Infrastructure:** Requires no cell towers, no central servers, and no internet backend.
* **Privacy First:** Fully anonymous operations with no registration, no user accounts, and no phone numbers required.
* **Cryptographic Security:** End-to-end encryption with forward secrecy powered by the Noise Protocol.

### Features
* **Decentralized Mesh Network:** Automatic peer discovery and multi-hop message relay over Bluetooth LE.
* **Privacy First:** No accounts, no phone numbers, no persistent identifiers.
* **Private Message End-to-End Encryption:** Noise Protocol optimized for mesh infrastructure.
* **IRC-Style Commands:** Familiar `/slap`, `/msg`, `/who` style interface.
* **Universal App:** Native support for iOS and macOS.
* **Emergency Wipe:** Triple-tap to instantly clear all data.
* **Performance Optimizations:** LZ4 message compression, adaptive battery modes, and optimized networking.

### Technical Architecture
OfflineMessenger uses a specialized offline messaging architecture focused entirely on local transport resilience:
* **Local Communication:** Direct peer-to-peer within Bluetooth range.
* **Multi-hop Relay:** Messages route through nearby devices (boosted up to 20 hops for wide rural coverage).
* **No Internet Required:** Works completely offline in disaster scenarios.
* **Noise Protocol Encryption:** End-to-end encryption with forward secrecy.
* **Binary Protocol:** Compact packet format optimized for Bluetooth LE constraints.
* **Automatic Discovery:** Peer discovery and connection management.
* **Adaptive Power:** Battery-optimized duty cycling.

### Use Case
Designed for emergency response and crisis communication in rural Central Europe. In regions experiencing full power grid collapse or mobile network outages (such as isolated municipalities in eastern Slovakia), OfflineMessenger functions as a mass user-layer mesh network to ensure localized coordination and vital data sharing.

### About this Adaptation
This fork was created by **Ing. Jozef Antol, MBA** as a localized, crisis-resilient adaptation of the open-source project [Bitchat](https://github.com/permissionlesstech/bitchat). It is purposefully optimized for rural safety infrastructure and maintained as a vital background IP layer within the *Domáca Pevnosť* citizen preparedness ecosystem.

### License
This adaptation inherits and is fully licensed under the terms of the **MIT License** (see the accompanying `LICENSE` file for full text).

---

## Slovak Section (Slovensky)

### Slogan
*Offline peer-to-peer mesh správy pre krízové scenáre — bez internetu, bez serverov, bez nutnosti infraštruktúry.*

### Čo aplikácia robí
OfflineMessenger je bezpečná, decentralizovaná komunikačná aplikácia navrhnutá špeciálne pre situácie, kedy zlyhajú tradičné komunikačné kanály.
* **Bluetooth Mesh Sieť:** Funguje kompletne offline. Šifrované pakety sú smerované priamo z jedného používateľského zariadenia na druhé.
* **Nulová infraštruktúra:** Nevyžaduje mobilné veže, centrálne servery ani internetové pripojenie.
* **Ochrana súkromia:** Plne anonymná prevádzka bez nutnosti registrácie, telefónnych čísel alebo používateľských účtov.
* **Kryptografická bezpečnosť:** End-to-end šifrovanie s doprednou tajnosťou (forward secrecy) pomocou protokolu Noise Protocol.

### Funkcie aplikácie
* **Decentralizovaná Mesh Sieť:** Automatické vyhľadávanie partnerov (peer discovery) a viackrokové preposielanie správ cez Bluetooth LE.
* **Súkromie na prvom mieste:** Žiadne účty, telefónne čísla ani trvalé identifikátory.
* **End-to-End šifrovanie správ:** Noise protokol optimalizovaný pre mesh infraštruktúru.
* **Príkazy v štýle IRC:** Známe rozhranie pre príkazy ako `/slap`, `/msg`, `/who`.
* **Univerzálna aplikácia:** Natívna podpora pre iOS a macOS.
* **Núdzové vymazanie:** Trojitým klepnutím okamžite vymažete všetky lokálne dáta.
* **Optimalizácia výkonu:** Kompresia správ pomocou LZ4, adaptívne režimy batérie a optimalizované sieťové protokoly.

### Technická architektúra
OfflineMessenger využíva špecializovanú offline architektúru zameranú na lokálnu odolnosť prenosu:
* **Lokálna komunikácia:** Priama komunikácia typu peer-to-peer v dosahu Bluetooth.
* **Viackrokové relé (Multi-hop):** Správy sa smerujú cez blízke zariadenia (zvýšené až na 20 skokov pre široké pokrytie vidieka).
* **Internet nie je potrebný:** Funguje úplne offline v katastrofických scenároch.
* **Šifrovanie Noise Protocol:** End-to-end šifrovanie s doprednou tajnosťou.
* **Binárny protokol:** Kompaktný format paketov optimalizovaný pre obmedzenia Bluetooth LE.
* **Automatické vyhľadávanie:** Správa objavovania partnerov a pripojenia.
* **Adaptívne napájanie:** Cyklovanie povinností optimalizované pre batériu.

### Scenár použitia
Aplikácia je vyvinutá prioritne pre **krízovú komunikáciu** na vidieku v strednej Európe. V prípade, že nastane celkový **výpadok mobilnej siete** alebo kolaps elektrickej siete, OfflineMessenger slúži pre **vidiecke obce** (napr. v rámci regiónu ako **Košický kraj**) ako masová používateľská komunikačná vrstva na koordináciu záchranných zložiek a obyvateľstva.

### O tejto adaptácii
Tento fork vytvoril **Ing. Jozef Antol, MBA** ako lokalizovanú adaptáciu open-source projektu [Bitchat](https://github.com/permissionlesstech/bitchat) upravenú pre krízové situácie. Projekt slúži ako technologické pozadie pre ekosystém pripravenosti obyvateľstva *Domáca Pevnosť*.

### Licencia
Táto úprava dedí podmienky a je plne licencovaná pod **MIT licenciou** (úplné znenie nájdete v priloženom súbore `LICENSE`).

---

## Target Deployment & Architecture

OfflineMessenger functions as the foundational mass user layer within a resilient **3-layer architecture**:
1.  **Mass User Layer:** OfflineMessenger (Local Bluetooth LE mesh networking up to a boosted deployment ceiling).
2.  **Medium-Range Bridge Layer:** Meshcore LoRa bridge nodes.
3.  **Long-Range Regional Layer:** HAM radio networks via ARES SZR interfaces.

---

## Setup & Implementation

### Option 1: Using Xcode
```bash
cd OfflineMessenger
open bitchat.xcodeproj
