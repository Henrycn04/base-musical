document.addEventListener('DOMContentLoaded', function () {
    const checkboxes = document.querySelectorAll('.filter-checkbox');
    const audioList = document.getElementById('audio-list');
    const clearFiltersButton = document.getElementById('clear-filters');
    
    // Lista de audios con sus filtros asociados
    const audios = [
        {
            src: 'audios/autentica_perfecta.mp3',
            filters: ['Cadencias', 'Armónicas', 'Conclusivas', 'Auténtica perfecta']
        },
        {
            src: 'audios/autentica_imperfecta.mp3',
            filters: ['Cadencias', 'Armónicas', 'Conclusivas', 'Auténtica imperfecta']
        },
        {
            src: 'audios/plagal.mp3',
            filters: ['Cadencias', 'Armónicas', 'Conclusivas', 'Plagal']
        },
        {
            src: 'audios/landini.mp3',
            filters: ['Cadencias', 'Armónicas', 'Conclusivas', 'Landini']
        },
        {
            src: 'audios/semicadencia_autentica.mp3',
            filters: ['Cadencias', 'Armónicas', 'Semi-conclusivas', 'Semicadencia auténtica']
        },
        {
            src: 'audios/semicadencia_plagal.mp3',
            filters: ['Cadencias', 'Armónicas', 'Semi-conclusivas', 'Semicadencia plagal']
        },
        {
            src: 'audios/autentica_deceptiva.mp3',
            filters: ['Cadencias', 'Armónicas', 'Desviaciones cadenciales', 'Auténtica deceptiva']
        },
        {
            src: 'audios/plagal_deceptiva.mp3',
            filters: ['Cadencias', 'Armónicas', 'Desviaciones cadenciales', 'Plagal deceptiva']
        },
        {
            src: 'audios/evadida.mp3',
            filters: ['Cadencias', 'Armónicas', 'Desviaciones cadenciales', 'Evadida']
        },
        {
            src: 'audios/abandonada.mp3',
            filters: ['Cadencias', 'Armónicas', 'Desviaciones cadenciales', 'Abandonada']
        },
        {
            src: 'audios/conclusivas.mp3',
            filters: ['Cadencias', 'Melódicas', 'Conclusivas']
        },
        {
            src: 'audios/semi-conclusivas.mp3',
            filters: ['Cadencias', 'Melódicas', 'Semi-conclusivas']
        },
        {
            src: 'audios/no-conclusivas.mp3',
            filters: ['Cadencias', 'Melódicas', 'No-conclusivas']
        },
    ];
    // Ocultar todos los sub-filtros al cargar la página
    function hideAllSubFilters() {
        const allSubFilters = document.querySelectorAll('.sub-filters');
        allSubFilters.forEach(subFilter => {
            subFilter.style.display = 'none';
        });
    }
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            toggleSubFilters(checkbox);
            filterAudios();
        });
    });

    clearFiltersButton.addEventListener('click', function () {
        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
            toggleSubFilters(checkbox);
        });
        filterAudios();
    });

    function toggleSubFilters(checkbox) {
        const subFilters = document.querySelectorAll(`.sub-filters[data-parent="${checkbox.dataset.filter}"]`);
        subFilters.forEach(subFilter => {
            if (checkbox.checked) {
                subFilter.style.display = 'block';
            } else {
                subFilter.style.display = 'none';
                const childCheckboxes = subFilter.querySelectorAll('.filter-checkbox');
                childCheckboxes.forEach(childCheckbox => {
                    childCheckbox.checked = false;
                    toggleSubFilters(childCheckbox);
                });
            }
        });
    }

    function filterAudios() {
        const selectedFilters = Array.from(checkboxes)
            .filter(checkbox => checkbox.checked)
            .map(checkbox => checkbox.dataset.filter);

        const filteredAudios = audios.filter(audio => {
            // Verifica si al menos uno de los filtros del audio coincide con los filtros seleccionados
            return selectedFilters.every(filter => audio.filters.includes(filter));
        });

        displayAudios(filteredAudios);
    }

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
    hideAllSubFilters();
    filterAudios();
});
