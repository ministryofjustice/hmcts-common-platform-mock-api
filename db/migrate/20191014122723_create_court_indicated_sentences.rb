class CreateCourtIndicatedSentences < ActiveRecord::Migration[6.0]
  def change
    create_table :court_indicated_sentences, id: :uuid do |t|
      t.uuid :courtIndicatedSentenceTypeId
      t.string :courtIndicatedSentenceDescription

      t.timestamps
    end
  end
end
