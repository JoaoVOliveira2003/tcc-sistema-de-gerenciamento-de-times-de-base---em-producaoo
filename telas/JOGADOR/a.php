<!DOCTYPE html>
<html lang="pt-br">
<head>
  <meta charset="UTF-8">
  <title>Contatos do Responsável</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="container mt-4">
    <h3>Cadastro de Responsáveis</h3>
    
    <form id="form-responsaveis">

    <div id="responsaveis-container">
        <div class="responsavel mb-3 border rounded p-3">
          <div class="row g-2">
            <div class="col-md-5">
              <input type="text" name="responsavel_nome[]" class="form-control" placeholder="Nome do Responsável" required>
            </div>
            <div class="col-md-5">
              <input type="text" name="responsavel_telefone[]" class="form-control" placeholder="Telefone do Responsável" required>
            </div>
            <div class="col-md-2 d-grid">
              <button type="button" class="btn btn-danger btn-remover">Remover</button>
            </div>
          </div>
        </div>
      </div>
      <div class="mb-3">
        <button type="button" class="btn btn-primary" id="adicionar-responsavel">Adicionar outro responsável</button>
      </div>
      <button type="submit" class="btn btn-success">Salvar</button>
    </form>
  </div>

  <!-- Bootstrap JS + Popper -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <script>
    document.getElementById('adicionar-responsavel').addEventListener('click', function () {
      const container = document.getElementById('responsaveis-container');
      const novo = container.firstElementChild.cloneNode(true);

      novo.querySelectorAll('input').forEach(input => input.value = '');

      container.appendChild(novo);
    });

    document.addEventListener('click', function (e) {
      if (e.target.classList.contains('btn-remover')) {
        const total = document.querySelectorAll('.responsavel').length;
        if (total > 1) {
          e.target.closest('.responsavel').remove();
        } else {
          alert("Pelo menos um responsável deve ser mantido.");
        }
      }
    });

  </script>
</body>
</html>
