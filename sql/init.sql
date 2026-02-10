CREATE TABLE IF NOT EXISTS usuario (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    criado_em TIMESTAMP NOT NULL DEFAULT NOW()
);

INSERT INTO usuario (nome, email)
VALUES
('João da Silva', 'joao.silva@example.com'),
('Maria Souza', 'maria.souza@example.com')
ON CONFLICT (email) DO NOTHING;
