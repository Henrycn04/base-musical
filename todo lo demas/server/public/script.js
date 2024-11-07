document.addEventListener('DOMContentLoaded', function () {
    const checkboxes = document.querySelectorAll('.filter-checkbox');
    const audioList = document.getElementById('audio-list');
    const filterContainer = document.getElementById('filter-container');
    const clearFiltersButton = document.getElementById('clear-filters');

    // Función para manejar el cambio de filtros
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            toggleSubFilters(checkbox);
            filterAudios();
        });
    });

    // Función para limpiar todos los filtros
    clearFiltersButton.addEventListener('click', function () {
        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
            toggleSubFilters(checkbox);
        });
        filterAudios();
        resetFilterBlocks();
    });

    // Función para desplegar o esconder sub-filtros y añadir nuevos bloques de filtros
    function toggleSubFilters(checkbox) {
        const subFilters = document.querySelectorAll(`.sub-filters[data-parent="${checkbox.dataset.filter}"]`);
        subFilters.forEach(subFilter => {
            if (checkbox.checked) {
                // Mostrar sub-filtros
                subFilter.style.display = 'block';

                // Crear un nuevo bloque para el siguiente filtro
                addFilterBlock(subFilter);
            } else {
                // Ocultar sub-filtros y sus descendientes
                subFilter.style.display = 'none';
                const childCheckboxes = subFilter.querySelectorAll('.filter-checkbox');
                childCheckboxes.forEach(childCheckbox => {
                    childCheckbox.checked = false;
                    toggleSubFilters(childCheckbox);
                });

                // Remover bloques de filtros adicionales
                removeFilterBlocks(subFilter);
            }
        });
    }

    // Función para añadir un nuevo bloque de filtro
    function addFilterBlock(subFilter) {
        const nextFilterBlock = document.createElement('div');
        nextFilterBlock.className = 'filter-block';
        const title = document.createElement('h3');
        const level = filterContainer.querySelectorAll('.filter-block').length + 1;
        title.textContent = `Filtro ${level}:`;

        nextFilterBlock.appendChild(title);
        nextFilterBlock.appendChild(subFilter.cloneNode(true)); // Clonar los sub-filtros para que sean independientes

        filterContainer.appendChild(nextFilterBlock);
    }

    // Función para remover bloques de filtros adicionales
    function removeFilterBlocks(subFilter) {
        const filterBlocks = filterContainer.querySelectorAll('.filter-block');
        filterBlocks.forEach(block => {
            const clonedSubFilter = block.querySelector(`.sub-filters[data-parent="${subFilter.dataset.parent}"]`);
            if (clonedSubFilter) {
                block.remove();
            }
        });
    }

    // Función para resetear los bloques de filtros
    function resetFilterBlocks() {
        const filterBlocks = filterContainer.querySelectorAll('.filter-block');
        filterBlocks.forEach((block, index) => {
            if (index > 0) block.remove();
        });
    }

    // Función para filtrar los audios según los filtros seleccionados
    function filterAudios() {
        const selectedFilters = Array.from(checkboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.dataset.filter);

        if (selectedFilters.length === 0) {
            // Si no hay filtros seleccionados, mostrar todos los audios
            fetchAudios('');
        } else {
            // Si hay filtros seleccionados, filtrar los audios
            fetchAudios(selectedFilters.join('/'));
        }
    }

    // Función para obtener y mostrar los audios desde el servidor
    function fetchAudios(filterPath) {
        fetch(`/audios/${filterPath}`)
            .then(response => response.json())
            .then(data => displayAudios(data))
            .catch(error => {
                console.error('Error fetching audios:', error);
                audioList.innerHTML = '<p>Error al cargar los audios.</p>';
            });
    }

    // Función para mostrar los audios en la página
    function displayAudios(filteredAudios) {
        audioList.innerHTML = '';

        if (filteredAudios.length === 0) {
            audioList.innerHTML = '<p>No se encontraron audios con los filtros seleccionados.</p>';
        } else {
            filteredAudios.forEach(audio => {
                const audioItem = document.createElement('div');
                audioItem.className = 'audio-item';

                // Crear el título que lista los filtros
                const audioTitle = document.createElement('p');
                audioTitle.textContent = `Este es ${audio.filters.join(', ')}`;
                audioItem.appendChild(audioTitle);

                // Crear el elemento de audio
                const audioElement = document.createElement('audio');
                audioElement.controls = true;
                audioElement.src = audio.src;

                audioItem.appendChild(audioElement);
                audioList.appendChild(audioItem);
            });
        }
    }

    // Inicializar con todos los audios mostrados
    filterAudios();
});
