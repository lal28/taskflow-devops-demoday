-- Criar a tabela de tarefas
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    completed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir algumas tarefas de exemplo
INSERT INTO tasks (title, description, completed) VALUES
    ('Configurar CI/CD', 'Implementar pipeline no GitLab', false),
    ('Dockerizar aplicação', 'Criar Dockerfile e docker-compose', false),
    ('Setup Terraform', 'Provisionar infraestrutura na AWS', false);