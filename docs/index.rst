:desc: Learn more about open-source natural language processing library Rasa NLU
       for intent classification and entity extraction in on premise chatbots.

.. _index:

Build contextual chatbots and AI assistants with Rasa
=====================================================

.. note::
    These docs are for Rasa 1.0 and later. Docs for older versions are at http://legacy-docs.rasa.com.

    This is the documentation for version |release| of Rasa. Please make sure you are reading the documentation
    that matches the version you have installed.


Rasa is an open source machine learning framework for automated text and voice-based conversations.
Understand messages, hold conversations, and connect to messaging channels and APIs.


.. toctree::
   :maxdepth: 1
   :caption: User Guide
   :hidden:

   user-guide/installation
   user-guide/rasa-tutorial
   user-guide/building-assistants
   user-guide/command-line-interface
   user-guide/architecture
   user-guide/messaging-and-voice-channels
   user-guide/testing-your-assistant
   user-guide/validate-files
   user-guide/configuring-http-api
   user-guide/how-to-deploy
   user-guide/cloud-storage

.. toctree::
   :maxdepth: 1
   :caption: NLU
   :hidden:

   About <nlu/about>
   nlu/using-nlu-only
   nlu/training-data-format
   nlu/language-support
   nlu/choosing-a-pipeline
   nlu/components
   nlu/entity-extraction
   nlu/using-bert

.. toctree::
   :maxdepth: 1
   :caption: Core
   :hidden:

   About <core/about>
   core/stories
   core/domains
   core/responses
   core/actions
   core/reminders-and-external-events
   core/policies
   core/slots
   core/forms
   core/retrieval-actions
   core/interactive-learning
   core/fallback-actions
   core/knowledge-bases

.. toctree::
   :maxdepth: 1
   :caption: Conversation Design
   :hidden:

   dialogue-elements/dialogue-elements
   dialogue-elements/small-talk
   dialogue-elements/completing-tasks
   dialogue-elements/guiding-users

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: API Reference

   api/action-server
   api/http-api
   api/jupyter-notebooks
   api/agent
   api/custom-nlu-components
   api/rasa-sdk
   api/events
   api/tracker
   api/tracker-stores
   api/event-brokers
   api/lock-stores
   api/training-data-importers
   api/core-featurization
   api/tensorflow_usage
   migration-guide
   changelog

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Migrate from (beta)

   Dialogflow <migrate-from/google-dialogflow-to-rasa>
   Wit.ai <migrate-from/facebook-wit-ai-to-rasa>
   LUIS <migrate-from/microsoft-luis-to-rasa>
   IBM Watson <migrate-from/ibm-watson-to-rasa>

.. toctree::
   :maxdepth: 1
   :hidden:
   :caption: Reference

   glossary
