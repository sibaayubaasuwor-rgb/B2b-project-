import { useState } from "react";

const GlobalStyles = () => (
  <style>{`
    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700;900&family=DM+Sans:wght@300;400;500;600&display=swap');
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    :root {
      --bg: #f7f5f0;
      --surface: #ffffff;
      --border: #e8e4dc;
      --text: #1a1714;
      --muted: #7a7470;
      --accent: #c0392b;
      --accent2: #2c3e50;
      --tag-bg: #f0ece4;
    }
    body { background: var(--bg); font-family: 'DM Sans', sans-serif; color: var(--text); }
    ::-webkit-scrollbar { width: 6px; }
    ::-webkit-scrollbar-track { background: var(--bg); }
    ::-webkit-scrollbar-thumb { background: var(--border); border-radius: 3px; }
    @keyframes fadeUp { from { opacity: 0; transform: translateY(18px); } to { opacity: 1; transform: translateY(0); } }
    @keyframes fadeIn { from { opacity: 0; } to { opacity: 1; } }
    @keyframes ticker { from { transform: translateX(0); } to { transform: translateX(-50%); } }
    .fade-up { animation: fadeUp 0.45s ease both; }
    .fade-in { animation: fadeIn 0.3s ease both; }
    .card-hover { transition: transform 0.2s, box-shadow 0.2s; }
    .card-hover:hover { transform: translateY(-3px); box-shadow: 0 8px 30px rgba(0,0,0,0.11); }
    button { font-family: 'DM Sans', sans-serif; }
    input, textarea, select { font-family: 'DM Sans', sans-serif; }
  `}</style>
);

const CATEGORIES = ["All", "Politics", "Technology", "Sports", "Science", "Entertainment", "World"];
const CAT_COLORS = { Politics: "#8B5E3C", Technology: "#1a6b9a", Sports: "#2d7a4f", Science: "#5b3d8a", Entertainment: "#b5451b", World: "#c0392b" };
const CAT_EMOJI  = { World: "🌍", Technology: "💡", Sports: "⚽", Politics: "🏛️", Science: "🔬", Entertainment: "🎬" };

const MOCK_USERS = [
  { id: 1, name: "Sarah Chen",    handle: "sarahchen", avatar: "SC", bio: "Senior journalist covering tech & policy.", followers: 3240, following: 180, posts: 42 },
  { id: 2, name: "Marcus Rivera", handle: "mrivera",   avatar: "MR", bio: "Sports reporter. Live for the game.",       followers: 1870, following: 95,  posts: 28 },
  { id: 3, name: "Aisha Patel",   handle: "aishap",    avatar: "AP", bio: "Science & environment correspondent.",     followers: 5100, following: 230, posts: 61 },
];

const MOCK_NEWS = [
  { id: 1, title: "Global Leaders Convene for Emergency Climate Summit in Geneva",      category: "World",         author: MOCK_USERS[2], time: "2h ago",  readTime: "4 min", excerpt: "World leaders gathered in Geneva today for an emergency summit addressing the accelerating pace of climate change, with 130 nations committing to ambitious new carbon reduction targets.", likes: 412,  comments: 58,  featured: true  },
  { id: 2, title: "Breakthrough in Quantum Computing Promises 1000x Speed Gains",      category: "Technology",    author: MOCK_USERS[0], time: "4h ago",  readTime: "3 min", excerpt: "Researchers at MIT unveiled a new quantum processor capable of performing complex calculations at speeds previously thought unattainable, potentially revolutionising cryptography and AI.", likes: 784,  comments: 103, featured: true  },
  { id: 3, title: "Championship Final Sets New Global Viewership Record",               category: "Sports",        author: MOCK_USERS[1], time: "6h ago",  readTime: "2 min", excerpt: "Last night's championship final drew over 2.1 billion viewers worldwide, shattering the previous record and solidifying the sport as a universal cultural phenomenon.", likes: 1024, comments: 215, featured: false },
  { id: 4, title: "Senate Passes Historic Infrastructure Spending Bill",                category: "Politics",      author: MOCK_USERS[0], time: "8h ago",  readTime: "5 min", excerpt: "In a rare bipartisan vote, the Senate approved a $1.2 trillion infrastructure package aimed at rebuilding roads, bridges, and expanding broadband access across rural America.", likes: 332,  comments: 77,  featured: false },
  { id: 5, title: "Scientists Discover New Deep-Sea Species Off Pacific Coast",         category: "Science",       author: MOCK_USERS[2], time: "10h ago", readTime: "3 min", excerpt: "Marine biologists have identified three previously unknown species in a deep-sea expedition off the coast of Chile, opening new avenues for understanding ocean biodiversity.", likes: 597,  comments: 44,  featured: false },
  { id: 6, title: "Award Season Preview: Films Poised to Dominate This Year",          category: "Entertainment", author: MOCK_USERS[0], time: "12h ago", readTime: "4 min", excerpt: "This year's award season is shaping up to be one of the most competitive in recent memory, with films spanning genres from intimate dramas to sweeping epics.", likes: 261,  comments: 39,  featured: false },
  { id: 7, title: "Central Bank Signals Rate Cuts Amid Cooling Inflation Data",         category: "Politics",      author: MOCK_USERS[1], time: "1d ago",  readTime: "3 min", excerpt: "The Federal Reserve hinted at upcoming interest rate reductions following new data showing inflation has cooled to its lowest level in three years.", likes: 189,  comments: 31,  featured: false },
  { id: 8, title: "AI Startup Raises $800M to Build General Purpose Reasoning Model",  category: "Technology",    author: MOCK_USERS[2], time: "1d ago",  readTime: "4 min", excerpt: "A stealthy AI startup emerged from stealth with an $800 million Series B, aiming to develop a reasoning model that generalises across scientific, legal, and creative domains.", likes: 923,  comments: 178, featured: false },
];

// ── Small helpers ──────────────────────────────────────────────────────────────
function Avatar({ user, size }) {
  const s = size || 36;
  return (
    <div style={{
      width: s, height: s, borderRadius: "50%",
      background: "var(--accent2)", color: "#fff",
      display: "flex", alignItems: "center", justifyContent: "center",
      fontWeight: 600, fontSize: s * 0.38, flexShrink: 0,
    }}>{user.avatar}</div>
  );
}

function CategoryTag({ cat, small }) {
  return (
    <span style={{
      fontSize: small ? 10 : 11, fontWeight: 600, letterSpacing: "0.08em",
      textTransform: "uppercase",
      color: CAT_COLORS[cat] || "var(--muted)",
      background: "var(--tag-bg)", borderRadius: "2px",
      padding: small ? "2px 6px" : "3px 8px",
      display: "inline-block",
    }}>{cat}</span>
  );
}

function Divider({ label }) {
  return (
    <div style={{ display: "flex", alignItems: "center", gap: 12, margin: "28px 0 20px" }}>
      <span style={{ fontSize: 11, fontWeight: 700, letterSpacing: "0.12em", textTransform: "uppercase", color: "var(--accent)", whiteSpace: "nowrap" }}>{label}</span>
      <div style={{ flex: 1, height: 1, background: "var(--border)" }} />
    </div>
  );
}

// ── Navbar ─────────────────────────────────────────────────────────────────────
function Navbar({ page, setPage, currentUser, setCurrentUser }) {
  return (
    <nav style={{
      position: "sticky", top: 0, zIndex: 100,
      background: "var(--surface)", borderBottom: "1px solid var(--border)",
      display: "flex", alignItems: "center", justifyContent: "space-between",
      padding: "0 32px", height: 60,
    }}>
      <div style={{ display: "flex", alignItems: "center", gap: 28 }}>
        <button onClick={() => setPage("home")} style={{
          fontFamily: "'Playfair Display', serif", fontWeight: 900,
          fontSize: 22, border: "none", background: "none", cursor: "pointer",
          letterSpacing: "-0.02em",
        }}>
          <span style={{ color: "var(--accent2)" }}>THE</span>
          <span style={{ color: "var(--accent)" }}>BRIEF</span>
        </button>
        <div style={{ display: "flex", gap: 2 }}>
          {[{ label: "Home", key: "home" }, { label: "Post News", key: "post" }].map(function(item) {
            return (
              <button key={item.key} onClick={() => setPage(item.key)} style={{
                background: page === item.key ? "var(--tag-bg)" : "none",
                border: "none", cursor: "pointer",
                padding: "6px 14px", borderRadius: "20px",
                fontSize: 14, fontWeight: page === item.key ? 600 : 400,
                color: page === item.key ? "var(--text)" : "var(--muted)",
                transition: "all 0.15s",
              }}>{item.label}</button>
            );
          })}
        </div>
      </div>
      <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
        {currentUser ? (
          <>
            <button onClick={() => setPage("profile")} style={{
              display: "flex", alignItems: "center", gap: 8,
              background: "none", border: "none", cursor: "pointer",
            }}>
              <Avatar user={currentUser} size={32} />
              <span style={{ fontSize: 14, fontWeight: 500 }}>{currentUser.name}</span>
            </button>
            <button onClick={() => { setCurrentUser(null); setPage("home"); }} style={{
              fontSize: 13, color: "var(--muted)", background: "none",
              border: "1px solid var(--border)", borderRadius: "20px",
              padding: "5px 14px", cursor: "pointer",
            }}>Sign out</button>
          </>
        ) : (
          <>
            <button onClick={() => setPage("login")} style={{
              fontSize: 13, color: "var(--muted)", background: "none",
              border: "none", cursor: "pointer", padding: "5px 10px",
            }}>Sign in</button>
            <button onClick={() => setPage("signup")} style={{
              fontSize: 13, fontWeight: 600, color: "#fff",
              background: "var(--accent)", border: "none",
              borderRadius: "20px", padding: "7px 18px", cursor: "pointer",
            }}>Get Started</button>
          </>
        )}
      </div>
    </nav>
  );
}

// ── NewsCard ───────────────────────────────────────────────────────────────────
function NewsCard({ article, featured, onAuthorClick, onRead }) {
  const [liked, setLiked] = useState(false);
  const color = CAT_COLORS[article.category] || "#999";

  if (featured) {
    return (
      <div className="fade-up card-hover" onClick={() => onRead(article)} style={{
        background: "var(--surface)", borderRadius: "4px",
        border: "1px solid var(--border)", cursor: "pointer",
        overflow: "hidden", gridColumn: "span 2",
        display: "grid", gridTemplateColumns: "1fr 1fr",
        boxShadow: "0 2px 16px rgba(0,0,0,0.07)",
      }}>
        <div style={{
          background: "linear-gradient(135deg," + color + "18," + color + "40)",
          display: "flex", alignItems: "center", justifyContent: "center",
          fontSize: 80, minHeight: 280,
        }}>
          {CAT_EMOJI[article.category] || "📰"}
        </div>
        <div style={{ padding: "32px 28px", display: "flex", flexDirection: "column", justifyContent: "space-between" }}>
          <div>
            <div style={{ marginBottom: 14 }}><CategoryTag cat={article.category} /></div>
            <h2 style={{ fontFamily: "'Playfair Display', serif", fontSize: 24, lineHeight: 1.35, fontWeight: 700, marginBottom: 14 }}>
              {article.title}
            </h2>
            <p style={{ fontSize: 14, color: "var(--muted)", lineHeight: 1.7 }}>{article.excerpt}</p>
          </div>
          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginTop: 20 }}>
            <button onClick={function(e) { e.stopPropagation(); onAuthorClick(article.author); }} style={{
              display: "flex", alignItems: "center", gap: 8,
              background: "none", border: "none", cursor: "pointer",
            }}>
              <Avatar user={article.author} size={28} />
              <span style={{ fontSize: 12, color: "var(--muted)" }}>{article.author.name} · {article.time}</span>
            </button>
            <span style={{ fontSize: 12, color: "var(--muted)" }}>{article.readTime} read</span>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="fade-up card-hover" onClick={() => onRead(article)} style={{
      background: "var(--surface)", borderRadius: "4px",
      border: "1px solid var(--border)", cursor: "pointer",
      padding: "22px 20px", display: "flex", flexDirection: "column",
      gap: 12, boxShadow: "0 2px 16px rgba(0,0,0,0.07)",
    }}>
      <CategoryTag cat={article.category} small={true} />
      <h3 style={{ fontFamily: "'Playfair Display', serif", fontSize: 17, lineHeight: 1.45, fontWeight: 700 }}>
        {article.title}
      </h3>
      <p style={{ fontSize: 13, color: "var(--muted)", lineHeight: 1.65, flexGrow: 1 }}>
        {article.excerpt.slice(0, 120)}...
      </p>
      <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between", marginTop: 4 }}>
        <button onClick={function(e) { e.stopPropagation(); onAuthorClick(article.author); }} style={{
          display: "flex", alignItems: "center", gap: 6,
          background: "none", border: "none", cursor: "pointer",
        }}>
          <Avatar user={article.author} size={22} />
          <span style={{ fontSize: 12, color: "var(--muted)" }}>{article.author.name} · {article.time}</span>
        </button>
        <button onClick={function(e) { e.stopPropagation(); setLiked(function(l) { return !l; }); }} style={{
          display: "flex", alignItems: "center", gap: 4, background: "none",
          border: "none", cursor: "pointer", fontSize: 12,
          color: liked ? "var(--accent)" : "var(--muted)",
        }}>
          {liked ? "♥" : "♡"} {article.likes + (liked ? 1 : 0)}
        </button>
      </div>
    </div>
  );
}

// ── HomePage ───────────────────────────────────────────────────────────────────
function HomePage({ setPage, setProfileUser, setReadArticle }) {
  const [activeCategory, setActiveCategory] = useState("All");
  const filtered = activeCategory === "All" ? MOCK_NEWS : MOCK_NEWS.filter(function(n) { return n.category === activeCategory; });
  const featured = filtered.filter(function(n) { return n.featured; });
  const rest = filtered.filter(function(n) { return !n.featured; });

  function goProfile(user) { setProfileUser(user); setPage("profile"); }
  function goRead(a) { setReadArticle(a); setPage("read"); }

  return (
    <div style={{ maxWidth: 1100, margin: "0 auto", padding: "32px 24px" }}>
      <div style={{ display: "flex", gap: 8, marginBottom: 32, flexWrap: "wrap" }}>
        {CATEGORIES.map(function(cat) {
          return (
            <button key={cat} onClick={() => setActiveCategory(cat)} style={{
              padding: "7px 18px", borderRadius: "20px", border: "1px solid",
              borderColor: activeCategory === cat ? "var(--accent)" : "var(--border)",
              background: activeCategory === cat ? "var(--accent)" : "var(--surface)",
              color: activeCategory === cat ? "#fff" : "var(--muted)",
              fontSize: 13, fontWeight: 500, cursor: "pointer", transition: "all 0.15s",
            }}>{cat}</button>
          );
        })}
      </div>

      {featured.length > 0 && <Divider label="Top Stories" />}

      <div style={{ display: "grid", gridTemplateColumns: "repeat(3, 1fr)", gap: 20 }}>
        {featured.map(function(a) { return <NewsCard key={a.id} article={a} featured={true} onAuthorClick={goProfile} onRead={goRead} />; })}
        {rest.map(function(a) { return <NewsCard key={a.id} article={a} onAuthorClick={goProfile} onRead={goRead} />; })}
      </div>

      {filtered.length === 0 && (
        <div style={{ textAlign: "center", padding: "80px 0", color: "var(--muted)" }}>
          <div style={{ fontSize: 48 }}>📭</div>
          <p style={{ marginTop: 12 }}>No stories in this category yet.</p>
        </div>
      )}
    </div>
  );
}

// ── ReadPage ───────────────────────────────────────────────────────────────────
function ReadPage({ article, setPage, setProfileUser, currentUser }) {
  const [liked, setLiked] = useState(false);
  const [commentText, setCommentText] = useState("");
  const [comments, setComments] = useState([
    { id: 1, user: MOCK_USERS[1], text: "Really insightful coverage, glad someone is tracking this closely.", time: "1h ago" },
    { id: 2, user: MOCK_USERS[2], text: "The numbers here are staggering. Looking forward to the follow-up piece.", time: "30m ago" },
  ]);

  if (!article) return null;

  function submitComment() {
    if (!commentText.trim() || !currentUser) return;
    setComments(function(c) { return [...c, { id: Date.now(), user: currentUser, text: commentText, time: "Just now" }]; });
    setCommentText("");
  }

  return (
    <div className="fade-in" style={{ maxWidth: 760, margin: "0 auto", padding: "40px 24px" }}>
      <button onClick={() => setPage("home")} style={{
        display: "flex", alignItems: "center", gap: 6,
        background: "none", border: "none", cursor: "pointer",
        color: "var(--muted)", fontSize: 13, marginBottom: 32,
      }}>← Back to news</button>

      <CategoryTag cat={article.category} />

      <h1 style={{
        fontFamily: "'Playfair Display', serif", fontSize: 36,
        lineHeight: 1.25, fontWeight: 900, margin: "16px 0 20px",
      }}>{article.title}</h1>

      <div style={{
        display: "flex", alignItems: "center", justifyContent: "space-between",
        borderTop: "1px solid var(--border)", borderBottom: "1px solid var(--border)",
        padding: "14px 0", marginBottom: 32,
      }}>
        <button onClick={() => { setProfileUser(article.author); setPage("profile"); }} style={{
          display: "flex", alignItems: "center", gap: 10,
          background: "none", border: "none", cursor: "pointer",
        }}>
          <Avatar user={article.author} size={38} />
          <div style={{ textAlign: "left" }}>
            <div style={{ fontSize: 14, fontWeight: 600 }}>{article.author.name}</div>
            <div style={{ fontSize: 12, color: "var(--muted)" }}>@{article.author.handle} · {article.time} · {article.readTime} read</div>
          </div>
        </button>
        <button onClick={() => setLiked(function(l) { return !l; })} style={{
          display: "flex", alignItems: "center", gap: 6,
          background: "none", border: "1px solid var(--border)",
          borderRadius: "20px", padding: "7px 16px", cursor: "pointer",
          fontSize: 14, color: liked ? "var(--accent)" : "var(--muted)",
          transition: "color 0.15s",
        }}>
          {liked ? "♥" : "♡"} {article.likes + (liked ? 1 : 0)}
        </button>
      </div>

      <div style={{ fontSize: 17, lineHeight: 1.85, color: "#2a2724" }}>
        <p>{article.excerpt}</p>
        <p style={{ marginTop: 20 }}>
          Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt
          ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
          laboris nisi ut aliquip ex ea commodo consequat.
        </p>
        <blockquote style={{
          borderLeft: "3px solid var(--accent)", paddingLeft: 20, margin: "28px 0",
          fontFamily: "'Playfair Display', serif", fontSize: 20,
          fontStyle: "italic", color: "var(--accent2)",
        }}>
          "This development marks a turning point that will have consequences for years to come."
        </blockquote>
        <p>
          Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.
          Vestibulum tortor quam, feugiat vitae, ultricies eget, tempor sit amet, ante.
        </p>
      </div>

      <div style={{ marginTop: 48 }}>
        <h3 style={{ fontFamily: "'Playfair Display', serif", fontSize: 20, marginBottom: 20 }}>
          Comments ({comments.length})
        </h3>

        {currentUser ? (
          <div style={{ display: "flex", gap: 10, marginBottom: 28 }}>
            <Avatar user={currentUser} size={34} />
            <div style={{ flex: 1 }}>
              <textarea
                value={commentText}
                onChange={function(e) { setCommentText(e.target.value); }}
                placeholder="Share your thoughts..."
                rows={3}
                style={{
                  width: "100%", padding: "10px 14px", fontSize: 14,
                  border: "1px solid var(--border)", borderRadius: "4px",
                  resize: "none", outline: "none", background: "var(--surface)",
                }}
              />
              <button onClick={submitComment} style={{
                marginTop: 8, padding: "7px 20px",
                background: "var(--accent2)", color: "#fff",
                border: "none", borderRadius: "20px",
                fontSize: 13, fontWeight: 600, cursor: "pointer",
              }}>Post Comment</button>
            </div>
          </div>
        ) : (
          <p style={{ fontSize: 13, color: "var(--muted)", marginBottom: 24 }}>
            <button onClick={() => setPage("login")} style={{ background: "none", border: "none", color: "var(--accent)", cursor: "pointer", fontWeight: 600, fontSize: 13 }}>Sign in</button>
            {" "}to leave a comment.
          </p>
        )}

        <div style={{ display: "flex", flexDirection: "column", gap: 14 }}>
          {comments.map(function(c) {
            return (
              <div key={c.id} style={{ display: "flex", gap: 10 }}>
                <Avatar user={c.user} size={30} />
                <div style={{ background: "var(--tag-bg)", borderRadius: "4px", padding: "10px 14px", flex: 1 }}>
                  <div style={{ fontSize: 13, fontWeight: 600 }}>
                    {c.user.name} <span style={{ color: "var(--muted)", fontWeight: 400 }}>· {c.time}</span>
                  </div>
                  <div style={{ fontSize: 14, marginTop: 4, lineHeight: 1.6 }}>{c.text}</div>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

// ── ProfilePage ────────────────────────────────────────────────────────────────
function ProfilePage({ user, setPage, setReadArticle, currentUser }) {
  if (!user) return null;
  const userArticles = MOCK_NEWS.filter(function(n) { return n.author.id === user.id; });
  const isOwn = currentUser && currentUser.id === user.id;

  return (
    <div className="fade-in" style={{ maxWidth: 860, margin: "0 auto", padding: "40px 24px" }}>
      <button onClick={() => setPage("home")} style={{
        background: "none", border: "none", cursor: "pointer",
        color: "var(--muted)", fontSize: 13, marginBottom: 28,
      }}>← Back</button>

      <div style={{
        background: "var(--surface)", border: "1px solid var(--border)",
        borderRadius: "4px", padding: "36px 32px",
        display: "flex", alignItems: "flex-start", gap: 28,
        boxShadow: "0 2px 16px rgba(0,0,0,0.07)", marginBottom: 32,
      }}>
        <Avatar user={user} size={84} />
        <div style={{ flex: 1 }}>
          <div style={{ display: "flex", alignItems: "center", justifyContent: "space-between" }}>
            <div>
              <h1 style={{ fontFamily: "'Playfair Display', serif", fontSize: 28, fontWeight: 700 }}>{user.name}</h1>
              <p style={{ color: "var(--muted)", fontSize: 14, marginTop: 2 }}>@{user.handle}</p>
            </div>
            {isOwn && (
              <button style={{
                padding: "7px 20px", border: "1px solid var(--border)",
                borderRadius: "20px", background: "none", fontSize: 13,
                cursor: "pointer", fontWeight: 500,
              }}>Edit Profile</button>
            )}
          </div>
          <p style={{ marginTop: 14, fontSize: 15, lineHeight: 1.6, color: "#3a3633" }}>{user.bio}</p>
          <div style={{ display: "flex", gap: 28, marginTop: 18 }}>
            {[["Posts", user.posts], ["Followers", user.followers.toLocaleString()], ["Following", user.following]].map(function(item) {
              return (
                <div key={item[0]}>
                  <div style={{ fontWeight: 700, fontSize: 18 }}>{item[1]}</div>
                  <div style={{ fontSize: 12, color: "var(--muted)" }}>{item[0]}</div>
                </div>
              );
            })}
          </div>
        </div>
      </div>

      <Divider label={"Stories by " + user.name} />

      <div style={{ display: "flex", flexDirection: "column", gap: 12 }}>
        {userArticles.map(function(a) {
          return (
            <div key={a.id} className="card-hover" onClick={() => { setReadArticle(a); setPage("read"); }} style={{
              background: "var(--surface)", border: "1px solid var(--border)",
              borderRadius: "4px", padding: "18px 20px",
              cursor: "pointer", display: "flex", alignItems: "center",
              justifyContent: "space-between", gap: 16,
            }}>
              <div>
                <div style={{ marginBottom: 6 }}><CategoryTag cat={a.category} small={true} /></div>
                <div style={{ fontFamily: "'Playfair Display', serif", fontSize: 16, fontWeight: 700 }}>{a.title}</div>
                <div style={{ fontSize: 12, color: "var(--muted)", marginTop: 4 }}>{a.time} · {a.readTime} read · ♡ {a.likes}</div>
              </div>
              <span style={{ color: "var(--muted)", fontSize: 18 }}>→</span>
            </div>
          );
        })}
        {userArticles.length === 0 && (
          <p style={{ color: "var(--muted)", fontSize: 14 }}>No stories published yet.</p>
        )}
      </div>
    </div>
  );
}

// ── PostPage ───────────────────────────────────────────────────────────────────
function PostPage({ setPage, currentUser }) {
  const [form, setForm] = useState({ title: "", category: "Technology", excerpt: "", body: "" });
  const [submitted, setSubmitted] = useState(false);

  const labelStyle = { display: "block", fontSize: 12, fontWeight: 600, letterSpacing: "0.07em", textTransform: "uppercase", color: "var(--muted)", marginBottom: 7 };
  const inputStyle = { width: "100%", padding: "11px 14px", border: "1px solid var(--border)", borderRadius: "4px", fontSize: 15, outline: "none", background: "var(--surface)" };

  if (!currentUser) {
    return (
      <div style={{ maxWidth: 520, margin: "80px auto", textAlign: "center", padding: "0 24px" }}>
        <div style={{ fontSize: 56 }}>✍️</div>
        <h2 style={{ fontFamily: "'Playfair Display', serif", fontSize: 26, margin: "16px 0 10px" }}>Sign in to post news</h2>
        <p style={{ color: "var(--muted)", marginBottom: 24 }}>You need an account to share stories.</p>
        <button onClick={() => setPage("signup")} style={{
          padding: "10px 28px", background: "var(--accent)", color: "#fff",
          border: "none", borderRadius: "24px", fontSize: 14, fontWeight: 600, cursor: "pointer",
        }}>Create an Account</button>
      </div>
    );
  }

  if (submitted) {
    return (
      <div className="fade-in" style={{ maxWidth: 520, margin: "80px auto", textAlign: "center", padding: "0 24px" }}>
        <div style={{ fontSize: 56 }}>🎉</div>
        <h2 style={{ fontFamily: "'Playfair Display', serif", fontSize: 26, margin: "16px 0 10px" }}>Story Published!</h2>
        <p style={{ color: "var(--muted)", marginBottom: 24 }}>Your news is now live on TheBrief.</p>
        <button onClick={() => setPage("home")} style={{
          padding: "10px 28px", background: "var(--accent2)", color: "#fff",
          border: "none", borderRadius: "24px", fontSize: 14, fontWeight: 600, cursor: "pointer",
        }}>Back to Homepage</button>
      </div>
    );
  }

  return (
    <div className="fade-in" style={{ maxWidth: 700, margin: "0 auto", padding: "40px 24px" }}>
      <h1 style={{ fontFamily: "'Playfair Display', serif", fontSize: 32, fontWeight: 900, marginBottom: 6 }}>Post a Story</h1>
      <p style={{ color: "var(--muted)", fontSize: 14, marginBottom: 36 }}>Share news with the TheBrief community</p>

      <div style={{ marginBottom: 22 }}>
        <label style={labelStyle}>Headline</label>
        <input value={form.title} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { title: e.target.value }); }); }} style={inputStyle} placeholder="Write a compelling headline..." />
      </div>

      <div style={{ marginBottom: 22 }}>
        <label style={labelStyle}>Category</label>
        <select value={form.category} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { category: e.target.value }); }); }} style={Object.assign({}, inputStyle, { cursor: "pointer" })}>
          {CATEGORIES.filter(function(c) { return c !== "All"; }).map(function(c) { return <option key={c}>{c}</option>; })}
        </select>
      </div>

      <div style={{ marginBottom: 22 }}>
        <label style={labelStyle}>Summary (shown in feed)</label>
        <textarea rows={3} value={form.excerpt} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { excerpt: e.target.value }); }); }} style={Object.assign({}, inputStyle, { resize: "vertical" })} placeholder="Brief summary of the story..." />
      </div>

      <div style={{ marginBottom: 28 }}>
        <label style={labelStyle}>Full Story</label>
        <textarea rows={8} value={form.body} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { body: e.target.value }); }); }} style={Object.assign({}, inputStyle, { resize: "vertical" })} placeholder="Write the full article here..." />
      </div>

      <button
        onClick={function() { if (form.title && form.excerpt) { setSubmitted(true); } }}
        style={{
          padding: "12px 32px",
          background: form.title && form.excerpt ? "var(--accent)" : "var(--border)",
          color: form.title && form.excerpt ? "#fff" : "var(--muted)",
          border: "none", borderRadius: "24px",
          fontSize: 15, fontWeight: 700,
          cursor: form.title && form.excerpt ? "pointer" : "default",
          transition: "background 0.15s",
        }}
      >Publish Story</button>
    </div>
  );
}

// ── AuthPage ───────────────────────────────────────────────────────────────────
function AuthPage({ mode, setPage, setCurrentUser }) {
  const [form, setForm] = useState({ name: "", email: "", password: "" });
  const isSignup = mode === "signup";

  const labelStyle = { display: "block", fontSize: 12, fontWeight: 600, letterSpacing: "0.07em", textTransform: "uppercase", color: "var(--muted)", marginBottom: 7 };
  const inputStyle = { width: "100%", padding: "11px 14px", border: "1px solid var(--border)", borderRadius: "4px", fontSize: 15, outline: "none", background: "var(--surface)" };

  function handleSubmit() {
    if (isSignup) {
      var newUser = {
        id: 99,
        name: form.name || "New User",
        handle: (form.email || "user").split("@")[0],
        avatar: (form.name || "N")[0].toUpperCase(),
        bio: "TheBrief contributor.",
        followers: 0, following: 0, posts: 0,
      };
      setCurrentUser(newUser);
    } else {
      setCurrentUser(MOCK_USERS[0]);
    }
    setPage("home");
  }

  return (
    <div className="fade-in" style={{ maxWidth: 440, margin: "60px auto", padding: "0 24px" }}>
      <div style={{
        background: "var(--surface)", border: "1px solid var(--border)",
        borderRadius: "4px", padding: "40px 36px",
        boxShadow: "0 2px 16px rgba(0,0,0,0.07)",
      }}>
        <h1 style={{ fontFamily: "'Playfair Display', serif", fontSize: 28, fontWeight: 900, marginBottom: 6 }}>
          {isSignup ? "Join TheBrief" : "Welcome back"}
        </h1>
        <p style={{ color: "var(--muted)", fontSize: 14, marginBottom: 32 }}>
          {isSignup ? "Create your free account today." : "Sign in to your account."}
        </p>

        {isSignup && (
          <div style={{ marginBottom: 18 }}>
            <label style={labelStyle}>Full Name</label>
            <input value={form.name} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { name: e.target.value }); }); }} placeholder="Your name" style={inputStyle} />
          </div>
        )}

        <div style={{ marginBottom: 18 }}>
          <label style={labelStyle}>Email</label>
          <input type="email" value={form.email} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { email: e.target.value }); }); }} placeholder="you@email.com" style={inputStyle} />
        </div>

        <div style={{ marginBottom: 24 }}>
          <label style={labelStyle}>Password</label>
          <input type="password" value={form.password} onChange={function(e) { setForm(function(f) { return Object.assign({}, f, { password: e.target.value }); }); }} placeholder="Password" style={inputStyle} />
        </div>

        <button onClick={handleSubmit} style={{
          width: "100%", padding: "13px", background: "var(--accent)", color: "#fff",
          border: "none", borderRadius: "4px", fontSize: 15, fontWeight: 700, cursor: "pointer",
        }}>{isSignup ? "Create Account" : "Sign In"}</button>

        <p style={{ textAlign: "center", fontSize: 13, color: "var(--muted)", marginTop: 20 }}>
          {isSignup ? "Already have an account? " : "Don't have an account? "}
          <button onClick={() => setPage(isSignup ? "login" : "signup")} style={{
            background: "none", border: "none", color: "var(--accent)",
            cursor: "pointer", fontWeight: 600, fontSize: 13,
          }}>{isSignup ? "Sign in" : "Sign up"}</button>
        </p>
      </div>
    </div>
  );
}

// ── App ────────────────────────────────────────────────────────────────────────
export default function App() {
  const [page, setPage]               = useState("home");
  const [currentUser, setCurrentUser] = useState(null);
  const [profileUser, setProfileUser] = useState(null);
  const [readArticle, setReadArticle] = useState(null);

  function goProfile(user) { setProfileUser(user); setPage("profile"); }

  return (
    <>
      <GlobalStyles />
      <div style={{ minHeight: "100vh", background: "var(--bg)" }}>
        <Navbar page={page} setPage={setPage} currentUser={currentUser} setCurrentUser={setCurrentUser} />

        {page === "home" && (
          <div style={{ background: "var(--accent)", color: "#fff", fontSize: 12, fontWeight: 500, padding: "6px 0", overflow: "hidden", whiteSpace: "nowrap" }}>
            <span style={{ display: "inline-block", animation: "ticker 30s linear infinite" }}>
              {"  Breaking: Climate summit concludes with historic agreement  |  Tech stocks surge on quantum computing breakthrough  |  Championship final shatters global viewership record  |  Senate passes landmark infrastructure bill  |  New deep-sea species discovered off Pacific coast  " +
               "  Breaking: Climate summit concludes with historic agreement  |  Tech stocks surge on quantum computing breakthrough  |  Championship final shatters global viewership record  "}
            </span>
          </div>
        )}

        <main>
          {page === "home"    && <HomePage    setPage={setPage} setProfileUser={setProfileUser} setReadArticle={setReadArticle} />}
          {page === "read"    && <ReadPage    article={readArticle} setPage={setPage} setProfileUser={goProfile} currentUser={currentUser} />}
          {page === "profile" && <ProfilePage user={profileUser || currentUser} setPage={setPage} setReadArticle={setReadArticle} currentUser={currentUser} />}
          {page === "post"    && <PostPage    setPage={setPage} currentUser={currentUser} />}
          {page === "login"   && <AuthPage    mode="login"  setPage={setPage} setCurrentUser={setCurrentUser} />}
          {page === "signup"  && <AuthPage    mode="signup" setPage={setPage} setCurrentUser={setCurrentUser} />}
        </main>

        <footer style={{
          borderTop: "1px solid var(--border)", padding: "28px 32px",
          marginTop: 60, display: "flex", justifyContent: "space-between",
          alignItems: "center", fontSize: 13, color: "var(--muted)",
        }}>
          <span style={{ fontFamily: "'Playfair Display', serif", fontWeight: 700, fontSize: 16 }}>
            <span style={{ color: "var(--accent2)" }}>THE</span>
            <span style={{ color: "var(--accent)" }}>BRIEF</span>
          </span>
          <span>2026 TheBrief - All rights reserved</span>
        </footer>
      </div>
    </>
  );
}