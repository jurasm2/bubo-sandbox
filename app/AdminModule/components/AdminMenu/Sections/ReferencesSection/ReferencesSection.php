<?php

namespace AdminMenu\Sections;

class ReferencesSection extends Section {

    public function render() {
        $template = parent::initTemplate(dirname(__FILE__) . '/referencesSection.latte');

        $template->render();
    }


}
