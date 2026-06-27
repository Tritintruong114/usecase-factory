# CarbonPapertrail

## Slug
cbam-data-agent

## One-liner
Agent gom dữ liệu phát thải và chứng từ từ nhà cung cấp/nhà máy, kiểm tra thiếu sót, soạn gói trả lời CBAM/ESG cho buyer EU, rồi chờ compliance lead duyệt trước khi gửi.

## Market problem signal
- **Market / geography scanned:** Vietnam exporters and non-EU SME suppliers selling into the EU; adjacent global CBAM compliance signals from EU importers and third-country suppliers.
- **Source URLs:**
  - https://taxation-customs.ec.europa.eu/carbon-border-adjustment-mechanism_en
  - https://www.energytransitionpartnership.org/wp-content/uploads/2024/06/20240318_Final-CBAM-Assessment-Report-final.pdf
  - https://www.businesseurope.eu/wp-content/uploads/2025/02/2024-05_cbam_implementation_-_businesseurope_survey_results_and_recommendations-0c7-1.pdf
  - https://www.corporatecomplianceinsights.com/cbam-supply-chain-hurdles-eu/
  - https://vietnamlawmagazine.vn/vietnams-textile-industry-faces-pressure-from-eus-new-rules-from-2028-79756.html
- **Repeated pain observed:** EU green-trade rules are shifting from abstract policy into operational evidence requests: emissions data, supplier disclosures, traceability, carbon documentation, and digital product data. Multiple sources point to a specific pain: collecting granular emissions/supplier data from third-country producers is hard, manual, spreadsheet-heavy, and poorly understood by smaller suppliers.
- **Existing workaround:** Consultants, fragmented spreadsheets, buyer questionnaires, email back-and-forth with factories, default emission values where allowed, and ad hoc document folders.
- **Why this looks agent-worthy:** The workflow is recurring, messy, document-heavy, multi-party, deadline-driven, and risky if wrong. It needs judgment to detect missing evidence, tool use to collect/normalize files, proactive follow-up with suppliers, and human approval before external submission.
- **Confidence:** Medium. The regulatory pressure and data-collection pain are well supported; willingness-to-pay and exact Vietnam SME workflow need interviews.

## Target user
- **Segment:** Compliance/export operations teams at Vietnamese SME manufacturers/exporters supplying EU buyers in textile, garment, steel/aluminum-adjacent parts, packaging, or high-scrutiny supply chains.
- **Power-user or end-user:** Power-user
- **Market / geography:** Vietnam exporters serving EU buyers; expandable to ASEAN suppliers facing EU compliance evidence requests.
- **Buyer:** Export director, compliance lead, or operations owner.
- **User:** Compliance/admin/export operations staff who respond to buyer questionnaires and gather documents from factories/suppliers.

## Pain hypothesis
- **Current workflow:** EU buyer sends a CBAM/ESG/DPP-style questionnaire or document request. Compliance staff forward questions to factories/suppliers, chase missing energy/material/process data, collect PDFs/Excel sheets, rename files, reconcile conflicting answers, and manually draft a response.
- **Specific pain:** The painful part is not only knowing the regulation; it is the daily coordination work: asking the right supplier for the right data, spotting missing fields, translating buyer requirements into factory language, chasing follow-ups, and keeping an audit trail.
- **Frequency:** Monthly/quarterly reporting for CBAM-related buyers; more frequent during onboarding, annual compliance renewal, buyer audits, or when regulations change.
- **Why now:** CBAM moved into its 2026 compliance phase, while EU sustainability rules and Digital Product Passport expectations are pushing exporters to build data infrastructure earlier instead of treating compliance as one-off paperwork.
- **Current substitutes:** Email threads, Excel trackers, shared Drive folders, consultant-prepared templates, generic ESG software aimed at larger companies, and manual buyer portal uploads.

## Agent fit
| Axis | Score | Reason |
|---|---|---|
| Judgment | Yes | Must decide whether a document answers the buyer's request, whether evidence is missing, and which gaps need escalation. |
| Multi-step tool use | Yes | Read buyer request, parse spreadsheet/PDF, query internal trackers, email suppliers, update evidence folder, draft response. |
| Memory / context | Yes | Needs supplier history, previous answers, accepted templates, recurring buyer preferences, and past audit gaps. |
| Messy conversation | Yes | Supplier replies are often incomplete, multilingual, late, or sent as scattered attachments. |
| Proactive follow-up | Yes | Agent should chase suppliers before deadlines and escalate stale requests. |
| Human checkpoint | Yes | Compliance lead must approve anything sent to buyer or uploaded to a portal. |

## Agent flow
- **Trigger:** New buyer compliance request arrives by email, portal export, or uploaded questionnaire; or scheduled check before CBAM/ESG reporting deadlines.
- **Context / memory:** Buyer profile, supplier list, previous submitted answers, accepted document templates, product/material mapping, emission-data fields, deadline and escalation rules.
- **Plan:** Classify the request type, map each requested field to internal owner/supplier, identify reusable evidence, create a gap list, and schedule follow-ups.
- **Tools / integrations:** Gmail/Outlook, Google Drive/SharePoint, Google Sheets/Excel, PDF parser/OCR, supplier contact database, optional buyer portal checklist.
- **Decision points:** Is the requested item already covered by prior evidence? Is the supplier answer sufficient? Does a missing field block submission? Should this be escalated to compliance lead or factory manager?
- **Human checkpoint:** Compliance lead sees a review packet: completed fields, missing fields, uncertain evidence, drafted buyer response, and supplier follow-up log. They approve, edit, or reject before sending.
- **Action:** Send supplier follow-ups, organize evidence folder, draft buyer-facing response, create an audit trail, and prepare portal-ready attachments.
- **Follow-up:** Auto-remind suppliers on day 2/day 5, escalate before deadline, and reopen tasks if buyer asks for clarification.
- **Memory / learning update:** Store accepted answers, rejected evidence, supplier response reliability, buyer-specific phrasing, and reusable evidence mappings for next request.
- **Failure handling:** If a document cannot be parsed, flag it for manual review. If supplier data conflicts, mark contradiction instead of choosing silently. If email/Drive permission fails, show the affected item in the review queue.

## Control surface / user flow
- **Primary surface:** Compliance request inbox showing active buyer requests, deadline, completion percentage, and risk level.
- **Review queue:** Field-by-field checklist with status: found evidence, waiting supplier, needs human judgment, contradiction, ready to submit.
- **Approval / override actions:** Approve response, edit answer, request more evidence, assign supplier owner, escalate, mark not applicable, submit/send.
- **History / audit trail:** Every supplier request, attachment, edit, approval, and sent response is logged per buyer/product/request.
- **Settings:** Supplier contacts, reminder cadence, approved templates, buyer-specific language, required evidence fields, escalation thresholds.
- **Exception handling:** Unknown supplier owner routes to compliance lead; conflicting emissions data creates a flagged contradiction; missing deadline creates urgent escalation.

## MVP scope
- **v0 core loop:** Upload/paste buyer request → agent extracts required fields → maps to supplier/evidence tracker → drafts supplier follow-up emails → builds review checklist → compliance lead approves → agent sends supplier requests and prepares buyer response draft.
- **Must have:** Email + Drive integration, questionnaire parser, supplier contact mapping, review checklist, reminder schedule, approval gate, audit log.
- **Explicitly not v0:** Full carbon accounting engine, guaranteed CBAM calculation correctness, automatic portal submission, ERP integration, real-time emissions monitoring, consultant-grade legal advice.
- **Data needed:** 5-10 real buyer questionnaires, current supplier list, sample evidence documents, prior accepted responses, compliance owner's escalation rules.

## Risk questions for usecase-factory
- **Buyer clarity:** Is the buyer the Vietnamese exporter, their EU importer, or a consultant serving many exporters?
- **Pain intensity:** Is evidence collection frequent and painful enough outside the highest-risk CBAM categories, or is this mostly consultant-led today?
- **Willingness to pay:** Will SMEs pay for workflow automation before they feel direct penalties, or only after EU buyers make it contractually mandatory?
- **Substitute strength:** ESG/CBAM platforms already exist for larger companies; the wedge must be lightweight supplier-follow-up and evidence packaging for SMEs.
- **Feasibility:** Parsing arbitrary buyer questionnaires and supplier PDFs is feasible, but legal/regulatory correctness must remain human-approved.
- **GTM wedge:** Start with a narrow vertical where EU buyer pressure is visible and document workflows are repetitive, such as textile/garment exporters preparing for DPP/ESG evidence requests or CBAM-adjacent manufacturers.

## Factory command
```bash
/usecase-factory:run cbam-data-agent "Agent gom dữ liệu phát thải, chứng từ ESG/CBAM và supplier follow-up cho compliance/export operations team tại SME Việt Nam bán vào EU"
```
